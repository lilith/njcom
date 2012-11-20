# Use the app.rb file to load Ruby code, modify or extend the models, or
# do whatever else you fancy when the theme is loaded.


class Site
  # Uncomment the Rack::Static line below if your theme has assets
  # (i.e images or JavaScript).
  #
  # Put your assets in themes/<%= @name %>/public/<%= @name %>.
  #
  # use Rack::Static, :urls => ["/<%= @name %>"], :root => "themes/<%= @name %>/public"

  helpers do

  end
  
end
module Hardwired
  
  class Template

    def layout
      return meta.layout unless meta.layout.nil?
      return nil if in_layout_dir?
      return Paths.layout_subfolder + '/plugin_page' unless meta.bundle.nil?
      return Paths.layout_subfolder + '/page'
    end

    def hidden?
      flag?('hidden') or draft? #(!Base.development? and draft?)
    end

  end

end

