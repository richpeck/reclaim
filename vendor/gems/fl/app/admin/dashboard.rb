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
              panel "Recent Claims" do
                table_for Claim.completed.order(created_at: :desc).limit(10) do

                end
              end
            end # => / Claims

            ###################################
            ###################################

            # => Claims
            # => Recent Claims table
            column do
              panel "Recent Claims" do
                table_for Claim.completed.order(created_at: :desc).limit(10) do

                end
              end
            end # => / Claims

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
