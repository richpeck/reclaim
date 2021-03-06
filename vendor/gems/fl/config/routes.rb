########################################
########################################
##    _____            _              ##
##   | ___ \          | |             ##
##   | |_/ /___  _   _| |_ ___  ___   ##
##   |    // _ \| | | | __/ _ \/ __|  ##
##   | |\ \ (_) | |_| | ||  __/\__ \  ##
##   \_| \_\___/ \__,_|\__\___||___/  ##
##                                    ##
########################################
########################################

## Good resource
## https://gist.github.com/maxivak/5d428ade54828836e6b6#merge-engine-and-app-routes

########################################
########################################

## Routes ##
Rails.application.routes.draw do

  ########################################
  ########################################

    # => ActiveAdmin
    # => Used to provide an "admin" area for users (won't need this with RailsHosting's dashboard)
    if Object.const_defined?("ActiveAdmin")

      # => CKEditor
      mount Ckeditor::Engine => '/ckeditor' if Object.const_defined?("Ckeditor")

      # => Admin
      # => This should just show at /admin
      # => If the user needs to authenticate, they'll need to use /login etc
      # => Authentication should go to /login etc
      devise_for :users, ActiveAdmin::Devise.config
      ActiveAdmin.routes(self)

    end

  ########################################
  ########################################

    # Index
    # => Shows index of app
    root "application#show"

    ########################################
    ########################################

    # Robots.txt
    # => https://blog.ragnarson.com/2013/11/15/hide-your-staging-environment-from-google.html
    # => Need to block access to auth + claims pages
    get "robots.txt" => "application#robots", as: :robots

    ########################################
    ########################################

    # => Everything else
    # => Nodes shown through system
    resources :application, only: :show, path: "" # => url.com/:id

  ########################################
  ########################################

end
