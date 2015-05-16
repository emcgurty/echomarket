# Methods added to this helper will be available to all templates in the application.
#require 'date'
module ApplicationHelper

  # def get_active_advertisers()
    # @return_string = ''
    # @advert = Advertisers.find(:all, :readonly)
    # unless  @advert.blank?
      # d = Date.parse(Time.now)
      # current_year = d.year
      # current_month = d.mon
      # date_like = "#{current_year}-#{current_month}"
      # for ad in @advert
# 
        # @borrower_source= Borrowers.find(:all, :readonly, :conditions => ["advertiser_id = ? AND date_created like '#{date_like}%'", ad.advertiser_id ])
        # unless @borrower_source.blank?
          # for bb in @borrower_source
            # @return_string << bb.advertiser_id + ","
          # end
        # end  ## end unless
# 
        # @lender_source= Lenders.find(:all, :readonly, :conditions => ["advertiser_id = ? AND date_created like '#{date_like}%'", ad.advertiser_id ])
        # unless @lender_source.blank?
          # for ll in @lender_source
            # @return_string << ll.advertiser_id + ","
          # end
        # end  ## end unless
# 
      # end  ## end for ad
    # end ## end unless blank
    # return @return_string.chomp(",")
  # end  ## end def

  def get_image_path(sought_image_file_name)

    return_string = ''
    unless sought_image_file_name.blank?
      return_string = "/images/item_images/" + sought_image_file_name
    end
    return_string
  end

  def get_search_query_string()
    distance_sought =""
    build_search_query_string = ""
    @current_search = Searches.find(:first, :readonly, :conditions => ["id = ?", session[:rapid_id]])
    
    unless @current_search.blank?

      build_search_query_string = "<ul>" +   (@current_search.lender_or_borrower == 2 ? "Borrower Seeking Search Criteria" : "Lender Offering Search Criteria")  unless @current_search.lender_or_borrower.blank?
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
        @cat = Categories.find(:first, :readonly,  :conditions => ["category_id = ?", @current_search.category_id])
        if @cat
          build_search_query_string << "<li>Category '" + @cat.category_type + "</li> "
        end
      end

      build_search_query_string << "</ul>"
    end
    return build_search_query_string

  end

  def get_existing_searches(which)
    distance_sought =""
    build_search_query_string = ""
    @current_search = Searches.find(:all, :readonly, :conditions => ["lender_or_borrower = ? AND created_at > ?", which.to_i, Time.now - 1.days])
    unless @current_search.blank?
      no_repeat = false
      item_count = 1

      for bl in @current_search

        build_search_query_string = "<p>" +   (bl.lender_or_borrower == 2 ? "Lenders!  Borrowers seem to need..." : "Borrowers! Lenders may be offering...") + "</p>"  unless no_repeat
        no_repeat = true
        build_search_query_string << "<ul>Item # " +  item_count.to_s

        unless bl.keyword.blank?
          build_search_query_string << "<li>Item Description/Model: " + bl.keyword + "</li>"

        end

        unless bl.postal_code.blank?
          build_search_query_string << "<li>Item Postal Code " + bl.postal_code + (bl.zip_code_radius.blank? ? "</li>" : "")

          unless bl.zip_code_radius.blank?
            build_search_query_string << " and others within a "

            if (bl.zip_code_radius  == 1)
              distance_sought = "One Mile radius"
            elsif (bl.zip_code_radius  == 5)
              distance_sought = "Five Mile radius"
            elsif (bl.zip_code_radius  == 10)
              distance_sought = "Ten Mile radius"
            elsif (bl.zip_code_radius  == 25)
              distance_sought = "25 Mile radius"
            end
            build_search_query_string <<  distance_sought + "</li>"
          end
        end

        unless bl.start_date.blank? && bl.end_date.blank?
          @sd =  bl.start_date.strftime("%Y-%m-%d") unless bl.start_date.blank?
          @ed =  bl.end_date.strftime("%Y-%m-%d") unless bl.end_date.blank?
          build_search_query_string << "<li>Item " +  (bl.lender_or_borrower == 2 ? "sought " : "offered ") +
          "Date Range between " + @sd.to_s +  " and " + @ed.to_s + "</li>"
        end

        unless bl.category_id.blank?
          @cat = Categories.find(:first, :readonly, :conditions => ["category_id = ?", bl.category_id])
          if @cat
            build_search_query_string << "<li>Category '" + @cat.category_type + "'</li> "
          end
        end
        build_search_query_string << "<li>NEXT</li> "
        build_search_query_string << "</ul>"
        no_repeat =false
      end

    end
    return build_search_query_string

  end

end
