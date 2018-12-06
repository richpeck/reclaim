#################################################
#################################################
##    ___   _   __ _____    _ _ _              ##
##  /  __ \| | / /|  ___|  | (_) |             ##
##  | /  \/| |/ / | |__  __| |_| |_ ___  _ __  ##
##  | |    |    \ |  __|/ _` | | __/ _ \| '__| ##
##  | \__/\| |\  \| |__| (_| | | || (_) | |    ##
##   \____/\_| \_/\____/\__,_|_|\__\___/|_|    ##
##                                             ##
#################################################
#################################################

# => ActiveStorage
require 'active_storage'

# => We already have an active_storage_blobs table
# => So no need for a migration

#################################################
#################################################

# =>  If available?
if Object.const_defined?("Ckeditor")

  # => Allows us to upload to ActiveStorage
  # => https://github.com/galetahub/ckeditor/issues/795#issuecomment-438927177
  # => This should change, but just need to get it online
  class Ckeditor::Picture < Ckeditor::Asset
    include Rails.application.routes.url_helpers

    def url_content
      rails_blob_url(storage_data)
    end

    def url_thumb
      rails_representation_url(storage_data.variant(resize: "118x100"))
    end

    class << self
      def default_url_options
        Rails.application.config.action_mailer.default_url_options
      end
    end
  end

end

#################################################
#################################################
