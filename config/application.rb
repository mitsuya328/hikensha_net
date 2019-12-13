require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HikenshaNet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    initializer(:remove_action_mailbox_and_activestorage_routes, after: :add_routing_paths) { |app|
      app.routes_reloader.paths.delete_if {|path| path =~ /activestorage/}
      app.routes_reloader.paths.delete_if {|path| path =~ /actionmailbox/ }
    }

    config.generators do |g| g.test_framework :rspec,
                              fixtures: false,
                              view_specs: false,
                              helper_specs: false,
                              routing_specs: false
    end

    config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
