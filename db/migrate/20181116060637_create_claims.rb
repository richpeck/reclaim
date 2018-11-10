class CreateClaims < ActiveRecord::Migration::Current
  include ActiveRecord::Concerns::Base

  #########################################
  #########################################

    # => Up
    def up
      create_table table do |t| # => users stored through "associations"
        t.string		 :first
        t.string     :last
        t.string 		 :email
        t.string     :phone
        t.string     :mobile
        t.text       :address
        t.timestamps
      end
    end

  #########################################
  #########################################

end
