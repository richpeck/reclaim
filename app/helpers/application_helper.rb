module ApplicationHelper

  ## PDF Image View ##
  def pdf_image_url(image, options = {})
    options[:src] = ["file:///", Rails.root.join("app", "assets", "images", image)].join
    tag(:img, options)
   end

end
