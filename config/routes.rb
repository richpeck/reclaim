###############################################
###############################################
##       _____            _                  ##
##      | ___ \          | |                 ##
##      | |_/ /___  _   _| |_ ___  ___       ##
##      |    // _ \| | | | __/ _ \/ __|      ##
##      | |\ \ (_) | |_| | ||  __/\__ \      ##
##      \_| \_\___/ \__,_|\__\___||___/      ##
##                                           ##
###############################################
###############################################

# => The majority of routes are handled by the FL gem
# => Only really need specifics for different elements

###############################################
###############################################

## Routes ##
Rails.application.routes.draw do

  ###################################
  # GENERAL
  ###################################

    # => Pages (viewable to all)
    # => Use - instead of _ (friendly_id)

    # => https://www.damagereclaim.co.uk/about   (What We Do)          (redirect from "about-us")
    # => https://www.damagereclaim.co.uk/action  (Take Action)         (redirect from "take-action")
    # => https://www.damagereclaim.co.uk/faq     (FAQ's)               (redirect from "faq")
    # => https://www.damagereclaim.co.uk/rates   (Service Rates)       (redirect from "our-rates")
    # => https://www.damagereclaim.co.uk/claim   (Letter Builder)

    # => https://www.damagereclaim.co.uk/eoc-recharges-explained-and-avoid-unnecessary-bills/         (EOC Recharges Explained)
    # => https://www.damagereclaim.co.uk/avoiding-end-of-contract-recharges                           (Avoiding EOC Recharges)
    # => https://www.damagereclaim.co.uk/business-contract-hire-avoiding-end-of-contract-damage-bils  (Business Contract Hire)
    # => https://www.damagereclaim.co.uk/car-van-rental-cvr-returning-your-vehicle                    (Car & Van Rental // CVR)
    # => https://www.damagereclaim.co.uk/personal-contract-purchase-return-charges                    (Personal Contract Purchase // PCP)
    # => https://www.damagereclaim.co.uk/personal-contract-hire-pch-vehicle-return-standards          (Personal Contract Hire // PCH)
    # => https://www.damagereclaim.co.uk/im-a-business-save-me-money-on-damage-recharges              (I'm A Business)
    # => https://www.damagereclaim.co.uk/im-an-individual-with-personal-contract-hire-recharge        (I'm An Individual)

    # => https://www.damagereclaim.co.uk/privacy (Privacy Policy)
    # => https://www.damagereclaim.co.uk/terms   (Terms of Service)

    ###################################
    ###################################

    # => Redirects
    # => Allows you to point old URL's to new ones
    # => https://guides.rubyonrails.org/routing.html#redirection
    unless ("Meta::Redirect".constantize rescue nil).nil?

      # => Allows admin to set redirects for search engines etc
      Meta::Redirect.all.each do |redirect|
        get redirect.title, to: redirect(redirect.val, status: 301)
      end

    end

  ###################################
  ###################################

    # => Blog/News
    # => https://www.damagereclaim.co.uk/news/x
    # => https://www.damagereclaim.co.uk/news/x-helps-you-buy-more-stuff (X Helps You Buy More Stuff)
    resources :application, only: :show, path: :news, as: :news, news: true

    ###################################
    ###################################

    # => Claims / FAQ's
    # => Claims & FAQ's are "static" endpoints (they'll always be present)
    unless ("Meta::Option".constantize rescue nil).nil?
      resources :application, only: :create, path: :claims, as: :claims unless Meta::Option.find_by(ref: "private", val: "claims")
    end

  ###################################
  # APP
  ###################################

    # => Auth
    # => https://www.damagereclaim.co.uk/login
    # => https://www.damagereclaim.co.uk/register -> disabled for now

  ###################################
  ###################################

end

###############################################
###############################################
