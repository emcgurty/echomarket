# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def get_image_path(sought_image_file_name)

    return_string = ''
    unless @imgs.blank? 
      return_string = root_url + "/" +  sought_image_file_name
    end
    return_string
  end
end
