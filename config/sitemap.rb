##############################################
##############################################
##   _____ _ _                              ##
##  /  ___(_) |                             ##
##  \ `--. _| |_ ___ _ __ ___   __ _ _ __   ##
##   `--. \ | __/ _ \ '_ ` _ \ / _` | '_ \  ##
##  /\__/ / | ||  __/ | | | | | (_| | |_) | ##
##  \____/|_|\__\___|_| |_| |_|\__,_| .__/  ##
##                                  | |     ##
##                                  |_|     ##
##############################################
##############################################

## Domain ##
## This is used to set the base level of the Sitemap's URLs ##
SitemapGenerator::Sitemap.default_host = URI::HTTPS.build(host: ["www", Rails.application.credentials[Rails.env.to_sym][:app][:domain].downcase].join("."))

##############################################
##############################################

## Links ##
## This is used to create the various URLs in the sitemap etc ##
SitemapGenerator::Sitemap.create do

  ## General ##
  ## Used for the likes of "about", "legal", "privacy", "terms" etc ##
  %w(about legal privacy terms).each do |page|
    add page, priority: 0.3, changefreq: 'monthly'
  end

  ## Platforms ##
  ## Each platform reviewed here ##
  Meta::Platform.all.each do |platform|

    ## Main Reviews ##
    add platform.title, priority: 0.5, changefreq: 'monthly', lastmod: platform.updated_at

    ## Extras ##
    add [platform.title, 'reviews'].join("/"), changefreq: 'weekly'
    add [platform.title, 'availability'].join("/"), changefreq: 'monthly'
    add [platform.title, 'reviews'].join("/"), changefreq: 'weekly'
    add [platform.title, 'availability'].join("/"), changefreq: 'monthly'

  end

  ## Functionality ##
  ## Install / Deploy / Build ##


  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end

##############################################
##############################################
