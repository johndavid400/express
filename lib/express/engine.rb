module Express
  class Engine < ::Rails::Engine
    isolate_namespace Express

    require 'haml-rails'
    require 'jquery-rails'
    require 'jquery-ui-rails'
    require 'pry-rails'
    require 'faraday'
    require 'rspec-rails'
    require 'friendly_id'
    require 'dragonfly'
    require "font-awesome-rails"

    initializer "express.assets.precompile" do |app|
      app.config.assets.precompile += %w( express/application.scss )
    end

  end
end
