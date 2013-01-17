# This file is responsible for starting the application
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
    
    register Hardwired::Wordpress

    helpers do
      def cache_for(time)
        response['Cache-Control'] = "public, max-age=#{time.to_i}"
      end
    end

    before do
      redirect request.url.sub(/\/nathanaeljones\.com/, '/www.nathanaeljones.com'), 301 if request.host.start_with?("nathanaeljones.com")
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
      cache_for(dev? ? 30 : 60 * 60 * 24) #1 day
    end  

    before '/wp-content/*' do
      request.path_info = "/attachments" + request.path_info
    end

		#debugger
end

module Hardwired
  class Template
    def hidden?
      flag?('hidden') or draft?
    end
  end
end
