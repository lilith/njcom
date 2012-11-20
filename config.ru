require 'bundler/setup'
Bundler.require(:default)

require 'hardwired'
require './site'

require 'rack/cache'

use Rack::Cache,
  :metastore   => 'file:/var/cache/rack/meta',
  :entitystore => 'file:/var/cache/rack/body',
  :verbose     => true


run Site.new