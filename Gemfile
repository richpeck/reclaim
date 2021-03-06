########################################
########################################

# => Sources
source 'https://rubygems.org'
source 'https://rails-assets.org' # => (Heroku) https://github.com/tenex/rails-assets/issues/325

########################################
########################################

# => Ruby
# => https://github.com/cantino/huginn/blob/master/Gemfile#L4
ruby [RUBY_VERSION, '2.6.0'].min

# => Rails
gem 'rails', '~> 5.2', '>= 5.2.2'

# => Server
# => Default dev development for Rails 5 but still needs the gem....
# => https://richonrails.com/articles/the-rails-5-0-default-files
gem 'puma', groups: [:development, :staging] # => Production will use phusion with nginx

# => FL
# => Used for framework etc
gem 'fl', path: 'vendor/gems/fl'

# => DB
# => https://github.com/rrrene/projestimate/blob/master/Gemfile#L11
gem 'sqlite3', group: :development
gem 'pg',      group: :staging
gem 'mysql2',  group: :production

########################################
########################################

# Platform Specific
# http://bundler.io/v1.3/man/gemfile.5.html#PLATFORMS-platforms-

# => Win
gem 'tzinfo-data' if Gem.win_platform? # => TZInfo For Windows

# => Not Windows
unless Gem.win_platform?
  gem 'execjs'       		# => http://stackoverflow.com/a/6283074/1143732
  gem 'mini_racer' 		  # => http://stackoverflow.com/a/6283074/1143732
end

########################################
########################################

####################
#     Frontend     #
####################

## HAML & SASS ##
gem 'sass-rails', '~> 5.0', '>= 5.0.7'
gem 'uglifier', '~> 3.0'
gem 'haml', '~> 5.0', '>= 5.0.3'

## JS ##
gem 'coffee-rails', '~> 4.2', '>= 4.2.1'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'

## General ##
gem 'truncate_html', '~> 0.9.3'

########################################
########################################

####################
#     Backend      #
####################

## General ##
## Used to provide general backend support for Rails apps ##
gem 'bootsnap',     '>= 1.1.0', require: false # => Boot caching (introduced in 5.2.x)
gem 'hubspot-ruby', '~> 0.5.0'                 # => HubSpot integration (API wrapper) - used for claim management
gem 'uk_postcode',  '~> 2.1', '>= 2.1.3'       # => UK Postcode validation (https://github.com/threedaymonk/uk_postcode)

## WickedPDF ##
## Allows us to generate PDF letter from db settings ##
gem 'wicked_pdf', '~> 1.1' # => Allows us to implement letter builder in the backend

## Amazon S3 ##
## Allows us to store featured images on S3 (Heroku) ##
## https://devcenter.heroku.com/articles/active-storage-on-heroku#ephemeral-disk ##
gem "aws-sdk-s3", require: false, group: :staging

# => These are required to get the gem working, but their setup depends on which platform they're running
gem 'wkhtmltopdf-heroku', '~> 2.12', '>= 2.12.4.0', group: :staging # => Heroku
gem 'wkhtmltopdf_binary', '~> 0.12.3.2', group: :production # => Unix

# => For ActiveAdmin
# => Chartkick allows us to include charts
# => Groupdate allows us to group data by time periods (day, hour etc)
gem 'formadmin', '~> 0.2.1' # => FormAdmin custom theme for ActiveAdmin
gem 'chartkick', '~> 3.0', '>= 3.0.1' # => Chartkick (https://github.com/ankane/chartkick)
gem 'groupdate', '~> 4.1' # => Groupdate (https://github.com/ankane/groupdate)

########################################
########################################
