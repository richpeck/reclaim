class Claim < ApplicationRecord

  ###########################################################
  ###########################################################
  ##               _____ _       _                         ##
  ##              /  __ \ |     (_)                        ##
  ##              | /  \/ | __ _ _ _ __ ___                ##
  ##              | |   | |/ _` | | '_ ` _ \               ##
  ##              | \__/\ | (_| | | | | | | |              ##
  ##               \____/_|\__,_|_|_| |_| |_|              ##
  ##                                                       ##
  ###########################################################
  ###########################################################
  ##     Allows users to input claims into the system      ##
  ###########################################################
  ###########################################################

    ###############################
    # => Schema
    ###############################

    # => id       (auto generated)
    # => first    (first_name)
    # => last     (last_name)
    # => email    (email)
    # => phone    (contact_number)
    # => mobile   (mobile)
    # => address  (address)

    # => received (received // date)
    # =>

    ###############################

    # => Validations
    # => Ensure every attribute is present (cannot have bad)
    validates :first, :last, :email, :mobile, :address, presence: true, length: { minimum: 2 }

    # => Numbers
    # => Validates numericality
    validates :phone, :mobile, numericality: { only_integer: true }

    # => Email
    # => https://stackoverflow.com/a/49925333/1143732
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    # => Hubspot
    # => This is meant to fire after the event
    # => The aim is to populate Hubspot with new claims
    # => Whilst implemented previously, was not as robust as was required
    after_create :hubspot

    # => Scopes
    # => Allows us to split data dependent on nature of claim
    scope :completed, -> { where(id: "NOT NULL") }

  ###########################################################
  ###########################################################

  ########################
  ##   Class (public)   ##
  ########################

  ########################
  ## Instance (private) ##
  ########################

  private

    # => Hubspot
    # => Uses the "hubspot-ruby" gem
    # => https://github.com/adimichele/hubspot-ruby#authentication-with-an-api-key
    def hubspot
      puts "Hubspot"
    end

  ###########################################################
  ###########################################################

end
