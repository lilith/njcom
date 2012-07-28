source 'http://rubygems.org'

if ENV['LOGNAME'] == "nathanael2"
	gem 'nesta', :path => "../nesta"
	gem 'nesta-plugin-simplicity', :path => "../nesta-plugin-simplicity"
	gem 'nesta-plugin-tags', :path => "../nesta-plugin-tags"
  gem 'nesta-plugin-aliases', :path => "../nesta-plugin-aliases"
  gem 'nesta-plugin-wordpress', :path => "../nesta-plugin-wordpress"
else
	gem 'nesta', :path => "../nesta", :git => "git://github.com/nathanaeljones/nesta.git"
	gem 'nesta-plugin-simplicity', :git => "git://github.com/nathanaeljones/nesta-plugin-simplicity.git"
	gem 'nesta-plugin-tags', :git => "git://github.com/nathanaeljones/nesta-plugin-tags.git"
	gem 'nesta-plugin-aliases', :git => "git://github.com/nathanaeljones/nesta-plugin-aliases.git"
	gem 'nesta-plugin-wordpress', :git => "git://github.com/nathanaeljones/nesta-plugin-wordpress.git"
end


gem 'haml-edge'
gem 'erubis'

gem 'sinatra-reloader', :group => :development

# gem (RUBY_VERSION =~ /^1.9/) ? 'ruby-debug19': 'ruby-debug'
