###########################################################
###########################################################
##         _____             _             _             ##
##        /  __ \           | |           | |            ##
##        | /  \/ ___  _ __ | |_ __ _  ___| |_           ##
##        | |    / _ \| '_ \| __/ _` |/ __| __|          ##
##        | \__/\ (_) | | | | || (_| | (__| |_           ##
##        \____/\___/|_| |_|\__\__,_|\___|\__|           ##
##                                                       ##
###########################################################
###########################################################

# => Check if ActiveAdmin loaded
if Object.const_defined?('ActiveAdmin')

  ############################################################
  ############################################################

  ## Users ##
  ActiveAdmin.register Contact do

    ##################################
    ##################################

    # => Menu
    menu priority: 6, label: -> { [I18n.t("activerecord.models.contact.icon")|| nil, Contact.model_name.human(count: 2)].join(' ') }

    # => Params
    permit_params :first, :last, :email, :address

    # => Actions
    actions :all, except: :show

    # => Filter
    # => Not sure if there's a way to put these into a single declaration...
    filter :first
    filter :last
    filter :email
    filter :address

    ##################################
    ##################################

    # => Controller
    controller do
      def scoped_collection
         Claim.where type: "Contact"
      end
    end

    ##################################
    ##################################

    # => Index
    index title: [I18n.t("activerecord.models.contact.icon"), Contact.model_name.human(count: 2), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name]].join(' ') do
      selectable_column
      column :id,     sortable: "ID"
      column :first,  sortable: "First Name"
      column :last,   sortable: "Last Name"
      column "Email", sortable: "Email" do |x|
        link_to x.email, edit_admin_contact_path(x)
      end
      column :address, sortable: "Messages"
      %i(created_at updated_at).each do |x|
        column x, sortable: x
      end
      actions name: "Actions"
    end

    ##################################
    ##################################

    # => Create
    form title: [I18n.t("activerecord.models.contact.icon"), Contact.model_name.human(count: 2), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name]].join(' ') do |f|
      f.semantic_errors
      f.inputs "⚙️ Client" do
        f.input :first,     placeholder: "First Name"
        f.input :last,      placeholder: "Last Name"
        f.input :email,     placeholder: "Email"
        f.input :address,   placeholder: "Message"
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
