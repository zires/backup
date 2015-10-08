# encoding: utf-8

require File.expand_path('lib/backup/version')

Gem::Specification.new do |gem|
  gem.name        = 'backup_zh'
  gem.version     = Backup::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ['Michael van Rooijen', 'zires']
  gem.email       = 'zshuaibin@gmail.com'
  gem.homepage    = 'https://github.com/zires/backup/tree/qi_niu'
  gem.license     = 'MIT'
  gem.summary     = 'Fork form https://github.com/meskyanichi/backup and add Qiniu storage support.'
  gem.description = <<-EOS.gsub(/\s+/, ' ').strip
    Backup is a RubyGem, written for UNIX-like operating systems, that allows you to easily perform backup operations
    on both your remote and local environments. It provides you with an elegant DSL in Ruby for modeling your backups.
    Backup has built-in support for various databases, storage protocols/services, syncers, compressors, encryptors
    and notifiers which you can mix and match. It was built with modularity, extensibility and simplicity in mind. Please
    check https://github.com/meskyanichi/backup for more details.
  EOS

  gem.files = %x[git ls-files -- lib bin templates README.md LICENSE.md].split("\n")
  gem.require_path  = 'lib'
  gem.executables   = ['backup_zh']

  gem.required_ruby_version = '>= 2.0'

  # Gem Dependencies
  # Generated by `rake gemspec`. Do Not Edit.
  gem.add_dependency 'addressable', '= 2.3.5'
  gem.add_dependency 'atomic', '= 1.1.14'
  gem.add_dependency 'aws-ses', '= 0.6.0'
  gem.add_dependency 'buftok', '= 0.2.0'
  gem.add_dependency 'builder', '= 3.2.2'
  gem.add_dependency 'descendants_tracker', '= 0.0.3'
  gem.add_dependency 'diff-lcs', '= 1.2.5'
  gem.add_dependency 'dogapi', '= 1.20.0'
  gem.add_dependency 'dropbox-sdk', '= 1.5.1'
  gem.add_dependency 'equalizer', '= 0.0.9'
  gem.add_dependency 'excon', '= 0.31.0'
  gem.add_dependency 'faraday', '= 0.8.8'
  gem.add_dependency 'ffi', '= 1.9.3'
  gem.add_dependency 'flowdock', '= 0.4.0'
  gem.add_dependency 'fog', '= 1.19.0'
  gem.add_dependency 'formatador', '= 0.2.4'
  gem.add_dependency 'fuubar', '= 1.3.2'
  gem.add_dependency 'hipchat', '= 1.0.1'
  gem.add_dependency 'http', '= 0.5.0'
  gem.add_dependency 'http_parser.rb', '= 0.6.0'
  gem.add_dependency 'httparty', '= 0.12.0'
  gem.add_dependency 'json', '= 1.8.1'
  gem.add_dependency 'mail', '= 2.5.4'
  gem.add_dependency 'memoizable', '= 0.4.0'
  gem.add_dependency 'metaclass', '= 0.0.1'
  gem.add_dependency 'mime-types', '= 1.25.1'
  gem.add_dependency 'mini_portile', '= 0.5.2'
  gem.add_dependency 'mocha', '= 0.14.0'
  gem.add_dependency 'multi_json', '= 1.8.2'
  gem.add_dependency 'multi_xml', '= 0.5.5'
  gem.add_dependency 'multipart-post', '= 1.2.0'
  gem.add_dependency 'net-scp', '= 1.1.2'
  gem.add_dependency 'net-sftp', '= 2.1.2'
  gem.add_dependency 'net-ssh', '= 2.7.0'
  gem.add_dependency 'netrc', '= 0.7.7'
  gem.add_dependency 'nokogiri', '= 1.6.1'
  gem.add_dependency 'open4', '= 1.3.0'
  gem.add_dependency 'pagerduty', '= 2.0.1'
  gem.add_dependency 'polyglot', '= 0.3.3'
  gem.add_dependency 'qiniu', '= 6.3.2'
  gem.add_dependency 'rake', '= 10.3.2'
  gem.add_dependency 'rb-fsevent', '= 0.9.4'
  gem.add_dependency 'rb-inotify', '= 0.9.3'
  gem.add_dependency 'redcarpet', '= 3.0.0'
  gem.add_dependency 'rest-client', '= 1.7.2'
  gem.add_dependency 'rspec', '= 2.14.1'
  gem.add_dependency 'rspec-core', '= 2.14.7'
  gem.add_dependency 'rspec-expectations', '= 2.14.4'
  gem.add_dependency 'rspec-mocks', '= 2.14.4'
  gem.add_dependency 'ruby-hmac', '= 0.4.0'
  gem.add_dependency 'ruby-progressbar', '= 1.4.0'
  gem.add_dependency 'simple_oauth', '= 0.2.0'
  gem.add_dependency 'thor', '= 0.19.1'
  gem.add_dependency 'thread_safe', '= 0.1.3'
  gem.add_dependency 'timecop', '= 0.7.1'
  gem.add_dependency 'treetop', '= 1.4.15'
  gem.add_dependency 'twitter', '= 5.5.0'
  gem.add_dependency 'unf', '= 0.1.3'
  gem.add_dependency 'unf_ext', '= 0.0.6'
  gem.add_dependency 'xml-simple', '= 1.1.5'
  gem.add_dependency 'yard', '= 0.8.7.3'
end
