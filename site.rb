# This file is responsible for starting the application
require 'hardwired/compat/nesta'
require 'hardwired/compat/wordpress'

#Customize Hardwired::Rules
require './rules.rb'

#Set the root directory
Hardwired::Paths.root = ::File.expand_path('.', ::File.dirname(__FILE__))
Hardwired::Paths.content_subfolder = 'content'

##The location of the current file is used for calculating the default 'root' setting
class Site < Hardwired::Bootstrap
		require 'debugger' if development?

		#Load config.yml from the root
		config_file 'config.yml'

		register Hardwired::Nesta
		register Hardwired::Wordpress


		#debugger

		
		
end

#Add customizations to MySite
require './custom.rb'
