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
            column class:"charts column" do
              panel "📈 Growth" do
                 line_chart [
                   { name: "Users",  data: User.group_by_day(:created_at).count},
                   { name: "Claims", data: Claim.group_by_day(:created_at).count}
                 ], class: "Chart"
              end
            end

            ###################################
            ###################################

            # => Claims
            # => Recent Claims table
            column class: "claims column" do
              panel "📮 #{link_to 'Claims', admin_claims_path} (#{Claim.count})".html_safe do

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
                    column(:phone)      { |claim| claim.phone.empty? ? "❌" : claim.phone }
                    column(:mobile)     { |claim| claim.mobile.empty? ? "❌" : claim.mobile }
                    column(:postcode)   { |claim| claim.postcode }
                    column(:address)    { |claim| claim.address }
                    column(:created_at) { |claim| claim.created_at }
                    column(:updated_at) { |claim| claim.updated_at }
                  end

                end

              end

              # => Pages
              panel "🔏 #{link_to 'Pages', admin_pages_path} (#{Meta::Page.count})".html_safe do

                # => Header actions
                # => https://github.com/activeadmin/activeadmin/issues/2552
                # => https://devhub.io/repos/vigetlabs-chronolog
                header_action link_to "➕", new_admin_page_path, title: "Add New"

                # => Logic
                # => Doesn't have a fallback for nil records
                if !Meta::Page.any?
                  link_to "Add New", new_admin_page_path, class: "none"
                else
                  table_for Meta::Page.all.order(created_at: :desc).limit(10), class: "dashboard pages" do
                    column(:id)     { |page| page.id }
                    column(:ref)    { |page| page.ref }
                    column(:val)    { |page| truncate(strip_tags(page.val), length: 350, separator: ' ',  omission: '...') }
                  end

                end

              end

              # => Users
              panel "🤑 #{link_to 'Users', admin_users_path} (#{User.count})".html_safe do

                # => Header actions
                # => https://github.com/activeadmin/activeadmin/issues/2552
                # => https://devhub.io/repos/vigetlabs-chronolog
                header_action link_to "➕", new_admin_user_path, title: "Add New"

                # => Logic
                # => Doesn't have a fallback for nil records
                if !User.any?
                  link_to "Add New", new_admin_user_path, class: "none"
                else
                  table_for User.all.order(created_at: :desc).limit(10), class: "dashboard users" do
                    column(:id)         { |user| user.id }
                    column(:name)       { |user| user.name }
                    column(:email)      { |user| user.email }
                    column(:created_at) { |user| user.created_at }
                    column(:updated_at) { |user| user.updated_at }
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
