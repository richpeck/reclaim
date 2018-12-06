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

#################################################
#################################################

# => Allows us to upload to ActiveStorage
# => https://github.com/galetahub/ckeditor/issues/795#issuecomment-438927177
# => This should change, but just need to get it online
class Ckeditor::Asset < ApplicationRecord
  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Ckeditor::ActiveStorage

  attr_accessor :data
  has_one_attached :storage_data
end


#################################################
#################################################
