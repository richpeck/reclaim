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

  ##############################################
  ##############################################

    ## General ##
    ## Used for the /about, /action, /faq, /rates, /claim, /privacy, /terms pages (these don't change) ##
    %w(about action privacy terms).each do |page|
      add page, priority: 0.3, changefreq: 'monthly'
    end

    ## News ##
    ## Cycle through Meta::News ##
    if Object.const_defined?('Meta::News')

      ## News (Dynamic) ##
      Meta::News.each do |news|
        add news_path(news), priority: 0.3, changefreq: 'weekly'
      end

    end

    ## Functionality ##
    ## Claims / FAQ => can change relatively frequently ##

  ##############################################
  ##############################################

    ## Info ##
    ## Gives overview of syntax etc ##

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

  ##############################################
  ##############################################

end

##############################################
##############################################
