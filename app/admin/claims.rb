############################################################
############################################################
##             _____ _       _                            ##
##            /  __ \ |     (_)                           ##
##            | /  \/ | __ _ _ _ __ ___  ___              ##
##            | |   | |/ _` | | '_ ` _ \/ __|             ##
##            | \__/\ | (_| | | | | | | \__ \             ##
##             \____/_|\__,_|_|_| |_| |_|___/             ##
##                                                        ##
############################################################
############################################################

# => Check if ActiveAdmin loaded
if Object.const_defined?('ActiveAdmin')

  ############################################################
  ############################################################

  ## Users ##
  ActiveAdmin.register Claim do

    ##################################
    ##################################

    # => Menu
    menu priority: 2, label: -> { [I18n.t("activerecord.models.claim.icon")|| nil, Claim.model_name.human(count: 2)].join(' ') }

    # => Params
    permit_params :email, :password, :password_confirmation, profile_attributes: [:id, :name, :role, :public, :avatar]  # => :avatar_attributes: [:id, FL::FILE, :_destroy] // This used to give us deep nested model - but can just attach the asset directly without custom table now


  end

  ############################################################
  ############################################################

end

############################################################
############################################################