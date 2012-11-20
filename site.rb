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

		register Hardwired::Nesta
		register Hardwired::Wordpress

    helpers do
      def cache_for(time)
        response['Cache-Control'] = "public, max-age=#{time.to_i}"
      end
    end


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

    after '*' do 
      cache_for(3600)
    end  


		#debugger
end

module Hardwired
  class Template
    def hidden?
      flag?('hidden') or draft? #(!Base.development? and draft?)
    end
  end
end
