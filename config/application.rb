require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OpenPantry
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
      g.hidden_namespaces << :test_unit  # Hide unwanted generators
      # g.template_engine :slim # Select template engine
      g.helper false # Don't create view helpers
      g.test_framework  :rspec, :view_specs => false
      g.integration_tool :rspec
      g.fixture_replacement :factory_girl # Choose between fixtures and factories
      g.factory_girl dir: 'spec/factories'
      g.javascript_engine :js # Disable coffeescript
      # g.scaffold_controller "responders_controller" # from responders gem
    end


  end
end
