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
              link_to edit_admin_news_path(meta) do

                # => Concat required or only the last content_tag returned
                # => https://apidock.com/rails/ActionView/Helpers/TagHelper/content_tag#481-Content-tag-in-helpers
                content = image_tag("https://via.placeholder.com/350", class: "featured", "nopin" => "true")
                content << content_tag(:strong, meta.ref)
                content << content_tag(:span, truncate(strip_tags(meta.value), length: 350, separator: ' ',  omission: '...'))
                content

              end
            end

          else

            # => Table
            index title: [I18n.t("activerecord.models.meta/#{meta}.icon"), (models.try(:[], meta.to_sym).try(:[], :label) || model.model_name.human(count: 2)), '|', Rails.application.credentials[Rails.env.to_sym][:app][:name] ].join(' ') do
              selectable_column
              column :id,   sortable: "ID"
              column :slug, sortable: "Slug" if meta.to_sym == :page
              column :ref,  sortable: "Ref"
              column :val,  sortable: "Val" do |x|
                truncate(strip_tags(x.value), length: 350, separator: ' ',  omission: '...')
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
