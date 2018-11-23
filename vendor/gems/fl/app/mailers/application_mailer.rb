class ApplicationMailer < ActionMailer::Base

  ##########################################################
  ##########################################################

  # => Address
  # => http://stackoverflow.com/a/8106387/1143732
  @@address = Mail::Address.new FL::ApplicationHelper.credentials :app, :email
  @@address.display_name      = FL::ApplicationHelper.credentials :app, :domain

  # => Default
  # => http://stackoverflow.com/a/18579046/1143732
  default from:	@@address.format, template_path: "mailers"

  # Layout (app/views/layouts)
  layout "mailers/layouts/mailer"

  ##########################################################
  ##########################################################

    # For Admin "seeds" notification
    def new_user user
      @user = user
      mail to: @@address
    end

    # => Claims
    def new_claim claim
      @claim = claim
      mail to: (Rails.env.production? ? @@address : "support@pcfixes.com")
    end

  ##########################################################
  ##########################################################

end
