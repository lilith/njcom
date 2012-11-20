require 'bundler/setup'
Bundler.require(:default)

require 'hardwired'
require './site'

run Site.new