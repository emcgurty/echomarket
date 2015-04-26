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
  
  def get_search_query_string()
    distance_sought =""
    @current_search = Searches.find(session[:rapid_id])
    build_search_query_string = ""
    build_search_query_string << "<ul>" +   (@current_search.lender_or_borrower == 2 ? "Borrower Seeking Search Criteria" : "Lender Offering Search Criteria")  unless @current_search.lender_or_borrower.blank? 
    unless @current_search.keyword.blank?      
    build_search_query_string =  build_search_query_string + "<li>Item Description/Model: " + @current_search.keyword + "</li>"  
        
    end    
    
   unless @current_search.postal_code.blank?
    build_search_query_string << "<li>Item Postal Code " + @current_search.postal_code + (@current_search.zip_code_radius.blank? ? "</li>" : "")
    
    unless @current_search.zip_code_radius.blank?
      build_search_query_string << " and others within a "
     
      if (@current_search.zip_code_radius  == 1)
        distance_sought = "One Mile radius"
      elsif (@current_search.zip_code_radius  == 5)
        distance_sought = "Five Mile radius"      
      elsif (@current_search.zip_code_radius  == 10)
        distance_sought = "Ten Mile radius"
      elsif (@current_search.zip_code_radius  == 25)
        distance_sought = "25 Mile radius"   
      end
      build_search_query_string <<  distance_sought + "</li>"     
   end
   end
    
    unless @current_search.start_date.blank? && @current_search.end_date.blank?
    build_search_query_string << "<li>Item " +  (@current_search.lender_or_borrower == 2 ? "sought " : "offered ") +  
    "Date Range between " + @current_search.start_date.strftime("%Y-%m-%d") +  " and " + @current_search.end_date.strftime("%Y-%m-%d") + "</li>" 
    end 
       
 
    unless @current_search.category_id.blank?
      @cat = Categories.find(:first, :conditions => ["category_id = ?", @current_search.category_id]) 
      if @cat
        build_search_query_string = build_search_query_string + "<li>Category '" + @cat.category_type + "'</li> "
      end   
    end  
    
    build_search_query_string + "</ul>" 
   
  end
  
  
  
end
