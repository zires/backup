# encoding: utf-8
require 'backup/cloud_io/qi_niu'

module Backup
  module Storage
    class QiNiu < Base
      include Storage::Cycler
      class Error < Backup::Error; end

      attr_accessor :access_key, :secret_key
      attr_accessor :bucket
      attr_accessor :expires_in
      attr_accessor :max_retries, :retry_waitsec

      def initialize(model, storage_id = nil)
        super

        @max_retries        ||= 3
        @retry_waitsec      ||= 30

        @path ||= 'backups'
        path.sub!(/^\//, '')

        check_configuration
      end

      private

      def cloud_io
        @cloud_io ||= CloudIO::QiNiu.new(
          access_key: access_key,
          secret_key: secret_key,
          bucket: bucket,
          expires_in: expires_in,
          max_retries: max_retries,
          retry_waitsec: retry_waitsec
        )
      end

      def transfer!
        package.filenames.each do |filename|
          src = File.join(Config.tmp_path, filename)
          dest = File.join(remote_path, filename)
          Logger.info "Storing '#{ bucket }/#{ dest }'..."
          cloud_io.upload(src, dest)
        end
      end

      def remove!(package)
        Logger.info "Removing backup package dated #{ package.time }..."

        remote_path = remote_path_for(package)
        objects = cloud_io.objects(remote_path)

        raise Error, "Package at '#{ remote_path }' not found" if objects.empty?

        cloud_io.delete(objects)
      end

      def check_configuration
        required = %w{ access_key secret_key bucket }
        raise Error, <<-EOS if required.map {|name| send(name) }.any?(&:nil?)
          Configuration Error
          #{ required.map {|name| "##{ name }"}.join(', ') } are all required
        EOS
      end

    end
  end
end
