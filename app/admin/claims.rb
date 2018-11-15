############################################################
############################################################
##             _____ _       _                            ##
##            /  __ \ |     (_)                           ##
##            | /  \/ | __ _ _ _ __ ___  ___              ##
##            | |   | |/ _` | | '_ ` _ \/ __|             ##
##            | \__/\ | (_| | | | | | | \__ \             ##
##             \____/_|\__,_|_|_| |_| |_|___/             ##
##                                                        ##
############################################################
############################################################

# => Check if ActiveAdmin loaded
if Object.const_defined?('ActiveAdmin')

  ############################################################
  ############################################################

  ## Users ##
  ActiveAdmin.register Claim do

    ##################################
    ##################################

    # => Menu
    menu priority: 2, label: -> { [I18n.t("activerecord.models.claim.icon")|| nil, Claim.model_name.human(count: 2)].join(' ') }

    # => Params
    permit_params :first, :last, :email, :mobile, :address, :received, :from, :to, :escalation, :phone, :mobile, :insurance, :signed, :shown, :inspected, :employee, :noted, :acknowledge, :report, :subsequent, :card, :invoice, :images, :repair, :method, :additional, :vat

    # => Actions
    actions :all, except: :show

    ##################################
    ##################################

    # => Index
    index title: [I18n.t("activerecord.models.claim.icon"), Claim.model_name.human(count: 2), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name]].join(' ') do
      selectable_column
      column :id,     sortable: "ID"
      column :first,  sortable: "First Name"
      column :last,   sortable: "Last Name"
      column "Email", sortable: "Email" do |x|
        link_to x.email, edit_admin_claim_path(x)
      end
      column :phone,    sortable: "Phone"
      column :mobile,   sortable: "Mobile"
      column :postcode, sortable: "Postcode"
      column :address,  sortable: "Address"
      actions name: "Actions"
    end

    ##################################
    ##################################

    # => Create
    form title: [I18n.t("activerecord.models.claim.icon"), Claim.model_name.human(count: 2), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name]].join(' ') do |f|
      f.inputs "⚙️ Client" do
        f.input :first, placeholder: "First Name"
        f.input :last,  placeholder: "Last Name"
        f.input :email, placeholder: "Email"
        f.input :phone, placeholder: "Phone"
        f.input :mobile, placeholder: "Mobile"
        f.input :address, placeholder: "Address"
      end
      f.inputs "📜 Claim" do
        f.input :received
        f.input :from
        f.input :to
        f.input :escalation, placeholder: "Escalation"
      end
      f.inputs "❓ Questions" do
        f.input :insurance,   label: "Was insurance requirements and options pointed out to the client prior to commencement of the rental?"
        f.input :signed,      label: "Has a signed condition report been provided on commencement of the rental?"
        f.input :shown,       label: "Was the client showed round the vehicle pointing out previous damage prior to the handover of keys?"
        f.input :inspected,   label: "Did the conditions make it difficult to inspect the vehicle prior to commencement of the rental (i.e. picked up in the rain, dark, underground car park, etc)?"
        f.input :employee,    label: "Was there an employee present when handing over the vehicle?"
        f.input :noted,       label: "Was damage noted on a condition report when handing the vehicle back?"
        f.input :acknowledge, label: "Did our client acknowledge they caused the damage?"
        f.input :report,      label: "Did the client sign the damage condition report?"
        f.input :subsequent,  label: "Has subsequent damage been identified by the rental company after the vehicle has been checked in and handed over?"
        f.input :card,        label: "Has the damage charge already been deducted from our client’s card?"
        f.input :invoice,     label: "On the damage invoice, has all the damage been described correctly and matches the inbound condition report?"
        f.input :images,      label: "On the invoice have appropriate images been included evidencing the following:"
        f.input :repair,      label: "Is the cost of repair reasonable compared to the matrix provided?"
        f.input :method,      label: "Is the repair method reasonable for the damage that has been identified?"
        f.input :additional,  label: "Has the client been charged additional costs over and above the damage charges (i.e. damage handling fee, loss of usage)?"
        f.input :vat,         label: "Has VAT been applied to the invoice or estimate?"
      end
      f.submit
    end

    ##################################
    ##################################

  end

  ############################################################
  ############################################################

end

############################################################
############################################################
