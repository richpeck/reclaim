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
    permit_params :email, :password, :password_confirmation, profile_attributes: [:id, :name, :role, :public, :avatar]

    ##################################
    ##################################

    # => Index
    index title: [I18n.t("activerecord.models.claim.icon"), Claim.model_name.human(count: 2), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name]].join(' ') do
      selectable_column
      column :name, sortable: "Name"
      column 'Email' do |user|
          link_to user.email, edit_admin_user_path(user), title: "Edit", data: { placement: :right }
      end
      column 'Role' do |user|
          content_tag :span, user.role
      end
      column :sign_in_count
      column :current_sign_in_at
      column :last_sign_in_at
      actions
    end

    ##################################
    ##################################

    # => Create
    form title: [I18n.t("activerecord.models.claim.icon"), Claim.model_name.human(count: 2), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name]].join(' ') do |f|
      f.inputs "➡️ Client" do
        f.input :first, placeholder: "First Name"
        f.input :last,  placeholder: "Last Name"
        f.input :email, placeholder: "Email"
        f.input :phone, placeholder: "Phone"
        f.input :mobile, placeholder: "Mobile"
        f.input :address, placeholder: "Address"
      end
      f.inputs "☑️ Claim" do
        f.input :received
        f.input :from
        f.input :to
        f.input :escalation, placeholder: "Escalation"
      end
      f.inputs "ℹ️ Questions" do
        f.input :insurance
        f.input :signed
        f.input :shown
        f.input :inspected
        f.input :employee
        f.input :noted
        f.input :acknowledge
        f.input :report
        f.input :subsequent
        f.input :card
        f.input :invoice
        f.input :images
        f.input :repair
        f.input :method
        f.input :additional
        f.input :vat
      end
      f.submit
    end

    ##################################
    ##################################

  end

  ############################################################
  ############################################################

end

############################################################
############################################################
