# encoding: utf-8
require 'backup/cloud_io/base'
require 'qiniu'

::Qiniu::Storage.class_eval do

  # Hack:
  # https://github.com/qiniu/ruby-sdk 不支持列举资源（list）操作
  # http://developer.qiniu.com/docs/v6/api/reference/rs/list.html
  # TODO: Remove this when ruby-sdk support list
  def self.list(bucket, prefix, options = {})
    options[:bucket] = bucket
    options[:prefix] = prefix
    params = options.map{|k,v| "#{k}=#{v}" unless v.nil?}.compact.join('&')
    url = ::Qiniu::Config.settings[:rs_host] + '/list?' + params
    return ::Qiniu::HTTP.api_post(url, '', { :headers => {
      'Authorization' => 'QBox ' + ::Qiniu::Auth.generate_acctoken(url, ''),
      'Host' => 'rsf.qbox.me',
      'Content-Type' => 'application/x-www-form-urlencoded'
      }
    })
  end

end

module Backup
  module CloudIO
    class QiNiu < Base
      class Error < Backup::Error; end

      attr_reader :uptoken, :bucket, :expires_in, :access_key, :secret_key

      def initialize(options = {})
        super

        @access_key = options[:access_key]
        @secret_key = options[:secret_key]
        @bucket     = options[:bucket]
        @expires_in = options[:expires_in] || 31536000 # 3600*24*365

        establish_connection!
      end

      def upload(src, dest)
        Logger.info "\s\sUploading #{src} to Qiniu..."
        put_policy = Qiniu::Auth::PutPolicy.new(bucket, nil, expires_in)
        with_retries("Upload with put policy") do
          wrap_results Qiniu::Storage.upload_with_put_policy(put_policy, src, dest),
            success_info: "\s\sUpload to Qiniu success",
            fail_info: 'Upload to Qiniu failed!'
        end
      end

      def objects(remote_path)
        _, result, _ = Qiniu::Storage.list(bucket, remote_path)
        result['items']
      end

      def delete(objects)
        Logger.info "\s\sDeleting from Qiniu..."
        with_retries("DELETE objects") do
          objects.each do |object|
            wrap_results Qiniu::Storage.delete(bucket, object['key']),
              success_info: "\s\sDelete #{object['key']} success",
              fail_info: "Delete #{object['key']} from Qiniu failed!"
          end
        end
      end

      private

        def establish_connection!
          Qiniu.establish_connection! access_key: access_key, secret_key: secret_key
        end

        def wrap_results(results, options = {})
          code, result, response_headers = results
          if code == 200
            Logger.info options[:success_info]
            Logger.info result
          else
            Logger.error Error.new(<<-EOS)
              #{Logger.info options[:fail_info]}
              code: #{code}
              result: #{result}
              headers: #{response_headers}
            EOS
          end
        end

    end
  end
end
