require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end
$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'
require 'mini_transformer'

# Require the correct version of popen for the current platform
if RbConfig::CONFIG['host_os'] =~ /mingw|mswin/
  begin
    require 'win32/open3'
  rescue LoadError
    abort "Run `gem install win32-open3` to be able to run specs"
  end
else
  require 'open3'
end

Dir["#{File.expand_path('../support', __FILE__)}/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|
  #config.include Spec::Builders
  config.include Spec::Helpers
  #config.include Spec::Indexes
  #config.include Spec::Matchers
  #config.include Spec::Path
  #config.include Spec::Rubygems
  #config.include Spec::Platforms
  #config.include Spec::Sudo
end