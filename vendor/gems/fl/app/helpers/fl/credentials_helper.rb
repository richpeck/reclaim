module FL
  module CredentialsHelper

  	##########################
  	##########################

  		# => Credentials
      def credentials env=Rails.env, *type
        Rails.application.credentials[env.to_sym][:app][:domain]
      end

    ##########################
  	##########################

  end
end
