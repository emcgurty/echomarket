# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def get_image_path(sought_image_file_name)

    return_string = ''
    unless @imgs.blank? 
      #  Not happpy with being so specific as to the path
      return_string = "#{Rails.root}/app/assets/images/item_images/" + sought_image_file_name
    end
    return_string
  end
  
  
  
end
