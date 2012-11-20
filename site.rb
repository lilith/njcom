# This file is responsible for starting the application
require 'hardwired/compat/nesta'
require 'hardwired/compat/wordpress'


#Set the root directory
Hardwired::Paths.root = ::File.expand_path('.', ::File.dirname(__FILE__))
Hardwired::Paths.content_subfolder = 'content'

##The location of the current file is used for calculating the default 'root' setting
class Site < Hardwired::Bootstrap
		require 'debugger' if development?
		#Debugger.start(:post_mortem => true) if development?

		#Load config.yml from the root
		config_file 'config.yml'
    debugger if Hardwired::Config.config.nil?

		register Hardwired::Nesta
		register Hardwired::Wordpress

    get '/blog/:year' do |year|
      request[:year] = year
      select_menu = '/blog'
      render_file('/blog')
    end
    get '/blog/tags/:tag' do |tag|
      request[:tag] = tag
      select_menu = '/blog'
      render_file('/blog')
    end

    get %r{/google([0-9a-z]+).html?} do |code|
      "google-site-verification: google#{code}.html" if config.google_verify.include?(code)
    end 


		#debugger
end

#Add customizations to MySite
require './custom.rb'
