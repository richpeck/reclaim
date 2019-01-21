module ApplicationHelper

  ## PDF Image View ##
  def pdf_image_url(image, options = {})
    options[:src] = Rails.root.join(Rails.application.config.assets.prefix, image_path(image))
    tag(:img, options)
   end

end
