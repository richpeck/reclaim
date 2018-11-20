############################################################
############################################################
##    _____          _     _                         _    ##
##   |  _  \        | |   | |                       | |   ##
##   | | | |__ _ ___| |__ | |__   ___   __ _ _ __ __| |   ##
##   | | | / _` / __| '_ \| '_ \ / _ \ / _` | '__/ _` |   ##
##   | |/ / (_| \__ \ | | | |_) | (_) | (_| | | | (_| |   ##
##   |___/ \__,_|___/_| |_|_.__/ \___/ \__,_|_|  \__,_|   ##
##                                                        ##
############################################################
############################################################

## This is used to add custom pages (typically from Node) ##

############################################################
############################################################

# => Check if ActiveAdmin loaded
if Object.const_defined?('ActiveAdmin')

  ############################################################
  ############################################################

  ## Make Sure Table Exists ##
  ## It may be the case that the user has not migrated etc ##
  if ActiveRecord::Base.connection.table_exists? 'nodes'

    # => Dashboard
    # => This allows us to populate with all the data / info required to get claims processed
    # => Basic setup will take submitted claims and match them with anything they've used before
    ActiveAdmin.register_page 'Dashboard', as: "" do

      ###################################
      ###################################

        # => Menu
        # => Allows us to determine how item appears in menu
        menu priority: 0, label: '💻 Dashboard'

      ###################################
      ###################################

        # => Content (this is requied)
        # => Allows us to populate viewport
        content title: ['💻 Dashboard', '|', Rails.application.credentials[Rails.env.to_sym][:app][:name] ].join(' ') do

          # => Columns
          # => Allows us to showcase which content to show
          columns do

            ###################################
            ###################################

            # => Claims
            # => Recent Claims table
            column do
              panel "" do
                 line_chart User.group_by_day(:created_at).count
              end
            end

            ###################################
            ###################################

            # => Claims
            # => Recent Claims table
            column class: "claims column" do
              panel "📮 Claims (#{Claim.count})" do

                # => Header actions
                # => https://github.com/activeadmin/activeadmin/issues/2552
                # => https://devhub.io/repos/vigetlabs-chronolog
                header_action link_to "➕", new_admin_claim_path, title: "Add New"

                # => Logic
                # => Doesn't have a fallback for nil records
                if !Claim.any?
                  link_to "Add New", new_admin_claim_path, class: "none"
                else
                  table_for Claim.all.order(created_at: :desc).limit(10), class: "dashboard" do
                    column(:id)         { |claim| claim.id }
                    column(:first_name) { |claim| claim.first }
                    column(:last_name)  { |claim| claim.last }
                    column(:email)      { |claim| link_to claim.email, edit_admin_claim_path(claim) }
                    column(:phone)      { |claim| claim.phone }
                    column(:mobile)     { |claim| claim.mobile }
                    column(:postcode)   { |claim| claim.postcode }
                    column(:address)    { |claim| claim.address }
                    column(:created_at) { |claim| claim.created_at }
                    column(:updated_at) { |claim| claim.updated_at }
                  end

                end

              end

              panel "🔏 Pages (#{Claim.count})" do

                # => Header actions
                # => https://github.com/activeadmin/activeadmin/issues/2552
                # => https://devhub.io/repos/vigetlabs-chronolog
                header_action link_to "➕", new_admin_claim_path, title: "Add New"

                # => Logic
                # => Doesn't have a fallback for nil records
                if !Claim.any?
                  link_to "Add New", new_admin_claim_path, class: "none"
                else
                  table_for Claim.all.order(created_at: :desc).limit(10), class: "dashboard" do
                    column(:id)         { |claim| claim.id }
                    column(:first_name) { |claim| claim.first }
                    column(:last_name)  { |claim| claim.last }
                    column(:email)      { |claim| link_to claim.email, edit_admin_claim_path(claim) }
                    column(:phone)      { |claim| claim.phone }
                    column(:mobile)     { |claim| claim.mobile }
                    column(:postcode)   { |claim| claim.postcode }
                    column(:address)    { |claim| claim.address }
                    column(:created_at) { |claim| claim.created_at }
                    column(:updated_at) { |claim| claim.updated_at }
                  end

                end

              end
            end

            ###################################
            ###################################

          end

        end

      ###################################
      ###################################

    end

  end

  ############################################################
  ############################################################

end

############################################################
############################################################
