require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "8f96a37315860ce2e9f64a231412c7959dfd54e8015ab213863ba8fcc02665c9"

  url_format "/attachments/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end

