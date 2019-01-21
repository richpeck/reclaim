module ApplicationHelper

  ## PDF Image View ##
  def pdf_image_url(image, options = {})
    options[:src] = Rails.root.join(image)
    tag(:img, options)
   end

end
