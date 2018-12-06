class CreateClaims < ActiveRecord::Migration::Current
  include ActiveRecord::Concerns::Base

  #########################################
  #########################################

    # => Up
    def up
      create_table table do |t| # => users stored through "associations"

        # => General
        # => Used to manage various aspects of the claim within the system
        t.integer :hubspot_id

        # => Type
        # => This is used for the "Contact" model
        # => Allows us to use the same table for both
        t.string :type

        # => Client
        t.string		 :first
        t.string     :last
        t.string 		 :email
        t.string     :phone
        t.string     :mobile
        t.string     :postcode
        t.text       :address

        # => Company
        t.string    :company_name       # => Company name
        t.string    :company_contact    # => Company contact name
        t.string    :company_email      # => Company contact email
        t.string    :company_phone      # => Company contact phone number
        t.text      :company_address    # => Company address
        t.string    :company_postcode   # => Company postcode
        t.integer   :received           # => Needs to be enum in the model (received or deducted)
        t.date      :from
        t.date      :to
        t.integer   :escalation         # => Needs to be enum (received or deducted? // ECRCS or BVRLA)

        # => Questions
        t.boolean :insurance
        t.boolean :signed
        t.boolean :shown
        t.boolean :inspected
        t.boolean :employee
        t.boolean :noted
        t.boolean :acknowledge
        t.boolean :report
        t.boolean :subsequent
        t.boolean :card
        t.boolean :invoice
        t.boolean :images
        # => a) b) c) d) e)
        t.boolean :repair
        t.boolean :method
        t.boolean :additional
        t.boolean :vat

        t.timestamps
      end
    end

  #########################################
  #########################################

end
