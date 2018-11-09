require_relative 'boot'

require 'rails/all'

###############################################################
###############################################################
##        ___              _ _           _   _               ##
##       / _ \            | (_)         | | (_)              ##
##      / /_\ \_ __  _ __ | |_  ___ __ _| |_ _  ___  _ __    ##
##      |  _  | '_ \| '_ \| | |/ __/ _` | __| |/ _ \| '_ \   ##
##      | | | | |_) | |_) | | | (_| (_| | |_| | (_) | | | |  ##
##      \_| |_/ .__/| .__/|_|_|\___\__,_|\__|_|\___/|_| |_|  ##
##            | |   | |                                      ##
##            |_|   |_|                                      ##
###############################################################
###############################################################

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

###############################################################
###############################################################

module Damagereclaim
  class Application < Rails::Application

    # => Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # => ExceptionHandler
    # => Allows us to view custom 404/500 pages in dev
    #config.exception_handler = { dev: true }

    # => Assets
    # => From "assets.rb" file (remove if unnecessary)
    Rails.application.config.assets.version = '1.0'
    Rails.application.config.assets.paths << Rails.root.join('node_modules')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

  end
end

###############################################################
###############################################################
