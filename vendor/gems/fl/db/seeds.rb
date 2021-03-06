##########################################
##########################################
##########################################
##	 			_____               _     		##
##			/  ___|             | |    			##
##			\ `--.  ___  ___  __| |___ 			##
##			 `--. \/ _ \/ _ \/ _` / __|			##
##			/\__/ /  __/  __/ (_| \__ \			##
##			\____/ \___|\___|\__,_|___/			##
##																			##
##########################################
##########################################
##########################################

# => Functions etc
include ActiveRecord::Concerns::Seeds
include ActionDispatch::Routing::PolymorphicRoutes # => For polymorphic_url
include Rails.application.routes.url_helpers # => https://stackoverflow.com/a/27003581/1143732

require 'open-uri' # => URL test

##########################################
##########################################

# => Data
Rails.application.credentials[Rails.env.to_sym][:seeds].each do |model, refs|
  iterate model, refs
end

##########################################
##########################################

# => Users
User.create!(email: Rails.application.credentials[Rails.env.to_sym][:admin][:email], password: Rails.application.credentials[Rails.env.to_sym][:admin][:password], password_confirmation: Rails.application.credentials[Rails.env.to_sym][:admin][:password], profile_attributes: {role: :admin, name: Rails.application.credentials[Rails.env.to_sym][:app][:author]}, send_email: ENV['email'] || true) unless User.any?

##########################################
##########################################

## Seeds ##
seeds     = Rails.root.join('db', 'seeds')
excluded  = { folders: ['.', '..'], files:   ['.', '..'] }

##########################################
##########################################

## ./db/seeds Exists? ##
if Dir.exists? seeds

  ##########################################
  ##########################################

    ## Each Folder ##
    Dir.foreach seeds do |meta|

      ## Ignore ##
      next if excluded[:folders].include? meta

      ## Folders ##
      folder = Rails.root.join('db', 'seeds', meta)

      ## Files? ##
      unless Dir[File.join(folder, '*')].empty?

        ## Each File ##
        Dir.foreach folder do |file|

          ## Ignore ##
          next if excluded[:files].include? file

          ## Images vs Metas ##
          if meta == 'images'

            #create 'asset', {data: File.new(File.join(folder, file))}

          else

            ## Items ##
            ## https://stackoverflow.com/a/25999578/1143732 ##
    				attrs 				= Hash.new
            attrs[:slug]  = File.basename(file, ".*").gsub(%r(^([0-9][d-])), '')
            attrs[:html]  = Nokogiri::HTML::DocumentFragment.parse File.read(Rails.root.join('db', 'seeds', meta, file))

    				## Attributes ##
            %w(title date).each do |item|
            	attrs[item.to_sym] = attrs[:html].at(item).unlink.text if attrs[:html].at(item)
            end

            ## Create ##
            create ["meta", meta.titleize.singularize].join("_"), {slug: attrs[:slug], ref: (attrs[:title] || attrs[:slug]), val: attrs[:html].to_html, created_at: (attrs[:date].to_datetime if attrs[:date]) }.compact

          end

        end
      end
    end

  ###########################################
  ###########################################
  ##          _____ _ _                    ##
  ##         |  ___(_) |                   ##
  ##         | |_   _| | ___  ___          ##
  ##         |  _| | | |/ _ \/ __|         ##
  ##         | |   | | |  __/\__ \         ##
  ##         \_|   |_|_|\___||___/         ##
  ##                                       ##
  ###########################################
  ###########################################
  ## Because Heroku totally wipes the dyno ##
  ## before launching, we've had to use an ##
  ## S3 bucket for this. Sucks but have to ##
  ## do it.                                ##
  ###########################################
  ###########################################

    # => Files
    # => Get list of files from /private/images
    # => https://stackoverflow.com/a/50133403/1143732
    files = Dir.glob( File.join(".", "private", "images", "*") ).select{ |e| File.file? e }

    # => News
    # => Allows us to add featured images for news items
    if files.any?

      # => Update news
      Meta::News.all.each do |news|
        file = files.sample # => Random file
        news.featured_image.attach(io: File.open(file), filename: File.basename(file), content_type: 'image/jpeg') unless news.featured_image.attached? # => Upload stored files
      end

    end

  ##########################################
  ##########################################

end



##########################################
##########################################
##########################################
