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
    validates :first_name, :last_name, :email, :phone, :mobile, :address, presence: true, length: { minimum: 2 }

    # => Hubspot
    # => This is meant to fire after the event

    # => Scopes
    # => Allows us to split data dependent on nature of claim
    scope :completed, -> { where(id: "NOT NULL") }

  ###########################################################
  ###########################################################

  # Class (public)
  ###################


  # Instance (private)
  ###################


  ###########################################################
  ###########################################################

end
