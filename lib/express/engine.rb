module Express
  class Engine < ::Rails::Engine
    isolate_namespace Express

    require 'haml-rails'
    require 'jquery-rails'
    require 'jquery-ui-rails'
    require 'friendly_id'
    require 'dragonfly'
#    require "font-awesome-rails"
    require 'pg_search'

    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    initializer "express.assets.precompile" do |app|
      app.config.assets.precompile += %w( logo.png express/application.scss )
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

  end
end
