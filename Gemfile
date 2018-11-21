########################################
########################################

# => Sources
source 'https://rubygems.org'
source 'https://rails-assets.org' # => (Heroku) https://github.com/tenex/rails-assets/issues/325

########################################
########################################

# => Ruby
# => https://github.com/cantino/huginn/blob/master/Gemfile#L4
ruby [RUBY_VERSION, '2.5.3'].min

# => Rails
gem 'rails', '~> 5.2', '>= 5.2.1'

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
#gem 'turbolinks', '~> 5.0' # => Had to get rid of this (it's shit)
gem 'jbuilder', '~> 2.0'

########################################
########################################

####################
#     Backend      #
####################

## General ##
## Used to provide general backend support for Rails apps ##
gem 'bootsnap',     '>= 1.1.0', require: false        # => Boot caching (introduced in 5.2.x)
gem 'formadmin',    '~> 0.2.1'                        # => FormAdmin custom theme for ActiveAdmin
gem 'hubspot-ruby', github: 'adimichele/hubspot-ruby' # => HubSpot integration (API wrapper) - used for claim management
gem 'uk_postcode',  '~> 2.1', '>= 2.1.3'              # => UK Postcode validation (https://github.com/threedaymonk/uk_postcode)

# => For ActiveAdmin
# => Chartkick allows us to include charts
# => Groupdate allows us to group data by time periods (day, hour etc)
gem 'chartkick', '~> 3.0', '>= 3.0.1' # => Chartkick (https://github.com/ankane/chartkick)
gem 'groupdate', '~> 4.1' # => Groupdate (https://github.com/ankane/groupdate)

####################
#      Other       #
####################

########################################
########################################
