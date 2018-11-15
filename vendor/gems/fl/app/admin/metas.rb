############################################################
############################################################
##               __  __      _                            ##
##              |  \/  |    | |                           ##
##              | .  . | ___| |_ __ _ ___                 ##
##              | |\/| |/ _ \ __/ _` / __|                ##
##              | |  | |  __/ || (_| \__ \                ##
##              \_|  |_/\___|\__\__,_|___/                ##
##                                                        ##
############################################################
############################################################

## Info ##
models = {
  option:       {priority: 6},
  page:         {priority: 3},
  faq:          {priority: 4},
  news:         {priority: 5}
}
############################################################
############################################################

# => Check if ActiveAdmin loaded
if Object.const_defined?('ActiveAdmin')

  ############################################################
  ############################################################

  ## Make Sure Table Exists ##
  if ActiveRecord::Base.connection.table_exists? 'nodes'

    ## Get all Meta Models ##
    Node.where(title: 'meta').where.not(val: 'redirect').pluck(:val).each do |meta|

      ## Check ##
      unless (model = "Meta::#{meta.capitalize}".constantize rescue nil).nil?

      ############################################################
      ############################################################

        # => Model
        ActiveAdmin.register model, as: models.try(:[], meta.to_sym).try(:[], :resource) || meta.to_s do

          ##################################
          ##################################

          # => Actions
          actions :all, except: :show

          ##################################
          ##################################

          # => Menu
          menu priority: models.try(:[], meta.to_sym).try(:[], :priority), label: -> { [I18n.t("activerecord.models.meta/#{meta}.icon"), (models.try(:[], meta.to_sym).try(:[], :label) || model.model_name.human(count: 2))].join(' ') }

          ##################################
          ##################################

          # => Strong Params
          permit_params :slug, :ref, :val

          ##################################
          ##################################

          # => Index
          # => This is a hack-job, but wanted the "news" portion to be a grid...
          if meta.to_sym == :news

            # => Grid
            index title: [I18n.t("activerecord.models.meta/#{meta}.icon"), (models.try(:[], meta.to_sym).try(:[], :label) || model.model_name.human(count: 2)), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name] ].join(' '), as: :grid do |meta|
              content_tag :span, "test"
            end

          else

            # => Table
            index title: [I18n.t("activerecord.models.meta/#{meta}.icon"), (models.try(:[], meta.to_sym).try(:[], :label) || model.model_name.human(count: 2)), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name] ].join(' ') do
              selectable_column
              column :slug, sortable: "Slug" if meta.to_sym == :page
              column :ref, sortable: "Ref"
              column :val, sortable: "Val" do |x|
                truncate(strip_tags(x.value), length: 350, separator: ' ')
              end
              %i(created_at updated_at).each do |x|
                column x
              end
              actions name: "Actions"
            end

          end

          ##################################
          ##################################

          # =>  Form
          form multipart: true, title: [I18n.t("activerecord.models.meta/#{meta}.icon"), (models.try(:[], meta.to_sym).try(:[], :label) || model.model_name.human(count: 2)), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name]].join(' ') do |f|
            f.inputs '✔️ Details' do
              f.input :slug if meta.to_sym == :page
              f.input :ref, placeholder: "Title"
              f.input :val, as: :trix_editor, placeholder: "Content"
            end

            f.actions
        	end

        end

        ############################################################
        ############################################################

      end
    end
  end

  ############################################################
  ############################################################

end

############################################################
############################################################
