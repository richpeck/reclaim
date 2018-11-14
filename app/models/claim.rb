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
    # => postcode (zip)
    # => address  (address)

    # => received (received or deducted // date)
    # => from (date)
    # => to (date)
    # => escalation (text)

    # => insurance    (Was insurance requirements and options pointed out to the client prior to commencement of the rental? // bool)
    # => signed       (Has a signed condition report been provided on commencement of the rental? // bool)
    # => shown        (Was the client showed round the vehicle pointing out previous damage prior to the handover of keys? // bool)
    # => inspected    (Did the conditions make it difficult to inspect the vehicle prior to commencement of the rental (i.e. picked up in the rain, dark, underground car park, etc.)?  //bool)
    # => employee     (Was there an employee present when handing over the vehicle? //bool)
    # => noted        (Was damage noted on a condition report when handing the vehicle back? //bool)
    # => acknowledge  (Did our client acknowledge they caused the damage? //bool)
    # => report       (Did the client sign the damage condition report?  //bool)
    # => subsequent   (Has subsequent damage been identified by the rental company after the vehicle has been checked in and handed over? //bool)
    # => card         (Has the damage charge already been deducted from our client’s card? //bool)
    # => invoice      (On the damage invoice, has all the damage been described correctly and matches the inbound condition report? //bool)
    # => images       (On the invoice have appropriate images been included evidencing the following: //bool)
    # => a) b) c) d) e)
    # => repair       (Is the cost of repair reasonable compared to the matrix provided? //bool)
    # => method       (Is the repair method reasonable for the damage that has been identified? //bool)
    # => additional   (Has the client been charged additional costs over and above the damage charges (i.e. damage handling fee, loss of usage)? //bool)
    # => vat          (Has VAT been applied to the invoice or estimate? //bool)

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
