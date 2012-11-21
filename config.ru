require 'bundler/setup'
Bundler.require(:default)

require 'hardwired'

require 'rack/cache'
use Rack::Cache

require './site'
run Site.new