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
        t.string     :type

        # => Client
        t.string		 :first
        t.string     :last
        t.string 		 :email
        t.string     :phone
        t.string     :mobile
        t.string     :postcode
        t.text       :address

        # => Claim
        t.date      :received
        t.date      :from
        t.date      :to
        t.string    :escalation

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
