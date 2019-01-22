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

  ###########################################################
  ###########################################################

    # => Hubspot?
    # => Allows us to determine whether to send data to hubspot or not
    # => Defaults to true
    attr_accessor :hubspot_enabled # => Add to Hubspot on create/update
    attr_accessor :hubspot_destroy # => Remove from Hubspot on delete
    attr_accessor :send_email # => Determines whether to send "new claim" email or not

    # => Validations
    # => Because we've subclassed the Contact model from this, we need a way to stop validations
    # => Just make skip_validations as true to make it work
    attr_accessor :skip_validations

  ###########################################################
  ###########################################################

    # => Enumerators
    # => Received + Escalation are enumerators
    enum received:   [:received, :deducted]
    enum escalation: ['BVRLA',	'ECRCS']

  ###########################################################
  ###########################################################

    # => Validations
    # => Ensure every attribute is present (cannot have bad)
    validates :first, :last, :email, presence: true, length: { minimum: 2 } # => claimaint
    validates :postcode, :received, :from, :to, :escalation, :received, :company_name, :company_contact, :company_email, :company_phone, :company_address, :company_postcode, presence: true, unless: :skip_validations # => claim

    # => Numbers
    # => Validates numericality
    validates :phone, :mobile, :company_phone, numericality: { only_integer: true, allow_blank: true }, unless: :skip_validations

    # => Email
    # => https://stackoverflow.com/a/49925333/1143732
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :email, uniqueness: { case_sensitive: false, scope: :type, message: "already used for claim" },unless: :skip_validations

    # => Postcode
    # => Validates postcode to ensure format is correct
    # => https://github.com/threedaymonk/uk_postcode#tips-for-rails
    validates :postcode, :company_postcode, postcode: true, unless: :skip_validations

    # => Mobile / Phone
    # => Either required
    # => https://stackoverflow.com/a/2134917/1143732
    validate :mobile_or_phone, unless: :skip_validations

    # => Hubspot
    # => This is meant to fire after the event
    # => The aim is to populate Hubspot with new claims
    # => Whilst implemented previously, was not as robust as was required
    before_save :hubspot, if: Proc.new { |claim| claim.hubspot_enabled } # => Allows us to sync the data with hubspot (https://stackoverflow.com/questions/14804415/what-happens-between-after-validation-and-before-save)
    after_destroy :hubspot_delete, if: Proc.new { |claim| claim.hubspot_id && claim.hubspot_destroy } # => Allows us to determine if the contact should be deleted from the system

    # => Email
    # => Sends email to site owner
    after_create Proc.new { |claim| ApplicationMailer.new_claim(claim).deliver! }#, if: :send_email

  ###########################################################
  ###########################################################

    # => Scopes
    # => Allows us to split data dependent on nature of claim
    scope :completed, -> { where( hubspot_id: "NOT NULL" ) }

    # => Alias Attribute
    # => Allows us to change the name of various columns
    alias_attribute :first_name, :first
    alias_attribute :firstname, :first

    alias_attribute :last_name, :last
    alias_attribute :lastname, :last

  ###########################################################
  ###########################################################

  ########################
  ##   Class (public)   ##
  ########################

  ########################
  ## Instance (private) ##
  ########################

    # => Created At
    # => Allows us to format the value
    def created_at format=:long
      self[:created_at].to_formatted_s format
    end

    # => Postcode
    # => https://github.com/threedaymonk/uk_postcode#tips-for-rails
    def postcode=(str)
      super UKPostcode.parse(str).to_s
    end

    # => Hubspot destroy
    # => This needs to be implemented into admin area
    def hubspot_destroy
      true
    end

  # => Private
  # => Allows us to manage the system without exposing methods publicly
  private

    # => Hubspot
    # => Uses the "hubspot-ruby" gem
    # => https://github.com/adimichele/hubspot-ruby#authentication-with-an-api-key
    # => https://stackoverflow.com/questions/607069/using-activerecord-is-there-a-way-to-get-the-old-values-of-a-record-during-afte (for old ActiveRecord data)
    def hubspot
      begin

        ## If VID exists, use it to find the contact ##
        contact = self[:hubspot_id] ? Hubspot::Contact.find_by_id(self[:hubspot_id]) : Hubspot::Contact.find_by_email(email)

        ## Create or Update ##
        ## This should be refactored but works for now ##
        if contact
          contact.update!({ firstname: first, lastname: last, phone: phone, mobilephone: mobile, address: address, zip: postcode })
        else
          hubspot = Hubspot::Contact.create! email, { firstname: first, lastname: last, phone: phone, mobilephone: mobile, address: address, zip: postcode }
          self[:hubspot_id] = hubspot.vid
        end

      rescue Hubspot::RequestError => e

        # => JSON
        r = JSON.parse(e.response.to_s)

        # => Duplicate contact
        errors.add(:base, [r["message"], "(Hubspot)"].join(' ')) if r["message"]

        # => ValidationResults
        if r["validationResults"]
          r["validationResults"].each do |x|
            errors.add(x["name"].to_sym, [x["message"], "(Hubspot)"].join(' '))
            errors.add(:base, x)
          end
        end

        # => Prevents Save
        # => https://stackoverflow.com/a/19136658/1143732
        return false

      rescue
        return false
      end
    end

    # => Hubspot Delete
    # => Removes Hubspot listing when claim is deleted
    def hubspot_delete
      begin
        contact = Hubspot::Contact.find_by_id(hubspot_id)
        contact.destroy!
      rescue
        return false
      end
    end

    # => Mobile or Phone
    # => Accounts for either to be present
    def mobile_or_phone
      errors.add(:base, "Please specify a mobile, landline number (or both) ↴") if mobile.blank? && phone.blank?
    end

  ###########################################################
  ###########################################################

end
