class ApplicationController < ActionController::Base

  ##################################
  ##################################

    # => Responders Gem
    respond_to :html

    # => Authentication
    #http_basic_authenticate_with name: Rails.application.class.parent.to_s.downcase, password: "password" if Rails.env.staging?

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
    before_action :layout_vars, unless: -> { request.xhr? }

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
        when :contact
          @content = Contact.new # => Allows for contact form
        else
          params[:id] ||= "index"
          @content = (params[:news] ? Meta::News : Meta::Page).find_by_slug! params[:id]
      end

    end

  ##################################
  ##################################

    # => Create
    # => Works for claims + contact
    # => This processes the claims forms
    # => Outputs results to the /claims page
    def create
      # => Set content
      @content = params.key?(:claim) ? Claim.new(claim_params) : Contact.new(contact_params)

      # => Response
      respond_to do |format|

        # => Does it save?
        if @content.save

          format.js   { render json: (params.key?(:claim) ? "Claim Sent Successfully" : "Contact Request Sent Successfully - You Will Hear From Our Advisors Soon!") }
          format.html { redirect_to application_path(params.key?(:claim) ? "claims" : "contact"), flash: { notice: params.key?(:claim) ? "Claim Sent Successfully" : "Contact Request Sent Successfully" } }

        else

          format.js   { render json: (params.key?(:claim) ? "Error With Claim" : "Error With Contact") }
          format.html do
            params[:id] = params.key?(:claim) ? :claims : :contact # => Needs to be set
            render :show
          end

        end
      end
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
      params.require(:claim).permit(:first, :last, :email, :phone, :mobile, :address, :postcode, :received, :from, :to, :escalation, :insurance, :signed, :shown, :inspected, :employee, :noted, :acknowledge, :report, :subsequent, :card, :invoice, :images, :repair, :method, :additional, :vat).merge!({hubspot_enabled: true, send_email: true})
    end

    # => Contact Params
    def contact_params
      params.require(:contact).permit(:first, :last, :email, :phone, :address)
    end

    # => Layout Vars
    # => Gives us variables for the layout (set once and maintained in an instance var)
    def layout_vars

      # => Header Links
      @header_links = {
        "Take Action"     => application_path("action"),
        "About Us"        => application_path("about"),
        "What We Do"      => application_path("rates"),
        "Industry News"   => application_path("news"),
        "FAQ's"           => application_path("faq"),
      }

      # => Footer Links
      @footer_links = {
        "EOC Recharges Explained"          => application_path("eoc-recharges-explained"),
        "Avoiding EOC Recharges"           => application_path("avoiding-eoc-recharges"),
        "Business Contract Hire (CH)"      => application_path("business-contract-hire"),
        "Car & Van Rental (CVR)"           => application_path("car-van-rental"),
        "Personal Contract Purchase (PCP)" => application_path("personal-contract-purchase"),
        "Personal Contract Hire (PCH)"     => application_path("personal-contract-hire"),
        "I'm A Business"                   => application_path("business"),
        "I'm An Individual"                => application_path("individual"),
        "Our Rates"                        => application_path("rates"),
        "Contact Us"                       => application_path("contact")
      }
    end

 ##################################

end
