############################################################
############################################################
##               _   _                                    ##
##              | | | |                                   ##
##              | | | |___  ___ _ __ ___                  ##
##              | | | / __|/ _ \ '__/ __|                 ##
##              | |_| \__ \  __/ |  \__ \                 ##
##               \___/|___/\___|_|  |___/                 ##
##                                                        ##
############################################################
############################################################

# => Check if ActiveAdmin loaded
if Object.const_defined?('ActiveAdmin')

  ############################################################
  ############################################################

  ## Users ##
  ActiveAdmin.register User do

    ##################################
    ##################################

    # => Menu
    menu priority: 1, label: -> { [I18n.t("activerecord.models.user.icon")|| nil, User.model_name.human(count: 2)].join(' ') }

    # => Actions
    actions :all, except: :show

    # => Params
    permit_params :email, :password, :password_confirmation, profile_attributes: [:id, :name, :role, :public, :avatar]  # => :avatar_attributes: [:id, FL::FILE, :_destroy] // This used to give us deep nested model - but can just attach the asset directly without custom table now

    ##################################
    ##################################

    # => Index
    index title: [I18n.t("activerecord.models.user.icon"), User.model_name.human(count: 2), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name]].join(' ') do
      selectable_column
      column :name, sortable: "Name"
      column 'Email', sortable: "Email", id: "TEST" do |user|
          link_to user.email, edit_admin_user_path(user), title: "Edit", data: { placement: :right }
      end
      column 'Role', sortable: "Role" do |user|
          content_tag :span, user.role
      end
      column :sign_in_count
      column :current_sign_in_at
      column :last_sign_in_at
      actions name: "Actions"
    end

    # => Filter
    filter :email

    #[I18n.t("activerecord.models.user.icon"), 'Users'].join(' ')
    form title: [I18n.t("activerecord.models.user.icon"), User.model_name.human(count: 2), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name]].join(' ') do |f|
      f.inputs "👻 Profile", for: [:profile, f.object.profile || f.object.build_profile] do |p|
        p.input :name
        p.input :role, include_blank: false
        p.input :avatar, as: :file, hint: f.object.avatar.attached? ? image_tag(f.object.avatar.variant(resize: '150x150')) : content_tag(:span, "No Image Yet")
      end
      f.inputs "✔️ Details" do
        f.input :email
        f.input :password
        f.input :password_confirmation
      end
      f.actions
    end

  end

  ############################################################
  ############################################################

end

############################################################
############################################################
