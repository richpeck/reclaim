class ApplicationController < ActionController::Base

  ##################################
  ##################################

    # => Responders Gem
    respond_to :html

    # => Authentication
    http_basic_authenticate_with name: Rails.application.class.parent.to_s.downcase, password: "password" if Rails.env.staging?

  ##################################
  ##################################

    # => Settings
    # Header & Footer content defined in ApplicationHelper
    protect_from_forgery with: :exception

    # => Layout
    layout Proc.new { |c| Rails.application.credentials[Rails.env.to_sym][:app][:layout] || 'base' unless c.request.xhr? }

    # => Maintenance
    before_action Proc.new { @maintenance = Node.find_by(ref: "maintenance").try(:val) }, only: :show

    # => Extras
    before_action :layout_vars

  ##################################
  ##################################

    # => Page content
    # => All slugrouter requests passed here (including root)
    # => Liquid ref - https://github.com/Shopify/liquid/wiki/Liquid-for-Programmers#first-steps
    # => If not using bang operator in find, use || "No Content"
    def show

      # => If they're accessing "index", it should not be shown
      raise ActionController::RoutingError.new('Not Found') if params[:id] == "index"

      # => Needs to provide for FAQ's & News
      # => If you're viewing FAQ's or News, you need to have all that content served properly
      case params[:id].try(:to_sym)
        when :faq
          @content = Meta::Faq.all
        when :news
          @content = Meta::News.all
        when :claims
          @content = Claim.new # => Allows us to publish "claim" forms
        else
          @content = Meta::Page.find_by_slug! params[:id] || "index"
      end

    end

  ##################################
  ##################################

    # => Claims
    # => This processes the claims forms
    # => Outputs results to the /claims page
    def create
      @content = Claim.new claim_params
      @content.save
      redirect_to :show, id: :claims
    end

  ##################################
  ##################################

    # => Robots.txt
    # => http://api.rubyonrails.org/classes/ActionController/ConditionalGet.html#method-i-expires_in
    def robots
      expires_in 5.hours, public: true
      render plain: "User-agent: *\r\nSitemap: https://www.#{Rails.application.credentials[Rails.env.to_sym][:app][:domain]}/sitemap.xml.gz"
    end

  ##################################
  ##################################

  private

    # => Devise
    # => Sign In
    def after_sign_in_path_for(resource)
      Rails.application.routes.named_routes[:admin_root] ? admin_root_path : root_path
    end

    # => Devise
    # => Sign Out
    def after_sign_out_path_for(resource_or_scope)
      root_path
    end

    # => Claim Params
    def claim_params
      params.require(:claim).permit(:first, :last, :email, :phone, :mobile, :address, :postcode)
    end

    # => Layout Vars
    # => Gives us variables for the layout (set once and maintained in an instance var)
    def layout_vars

      # => Header Links
      @header_links = {
        "⚠️ Action" => "action",
        "ℹ️ About" => "about",
        "✔️ FAQ's" => "faq",
        "📰 News" => "news",
        "📜 Rates" => "rates",
        "🚩 Claims" => "claims"
      }
    end

 ##################################

end
