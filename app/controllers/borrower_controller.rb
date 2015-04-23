class BorrowerController < ApplicationController


def rapid_borrower_seeking
    distance_sought = '' 
    session[:notice] = ''
    session[:background] = true 
    @current_search = Searches.find(session[:rapid_id])
    @build_search_query_string = ""
    @build_search_query_string = "Item Description/Model" + @current_search.keyword unless @current_search.keyword.blank?
    unless  @build_search_query_string.blank? 
      @build_search_query_string = @build_search_query_string + "; "
    end
    @build_search_query_string = @build_search_query_string + "Item Postal Code " + @current_search.postal_code unless @current_search.postal_code.blank?
    unless  @build_search_query_string.blank? 
      @build_search_query_string = @build_search_query_string + "; "
    end
    unless @current_search.zip_code_radius.blank?
      if (@current_search.zip_code_radius  == 1)
        distance_sought = "One Mile"
      elsif (@current_search.zip_code_radius  == 5)
        distance_sought = "Five Miles"      
       elsif (@current_search.zip_code_radius  == 10)
        distance_sought = "Ten Miles"
        elsif (@current_search.zip_code_radius  == 25)
        distance_sought = "25 Miles"   
      end
    end
    
    @build_search_query_string = @build_search_query_string + "Item Postal Code Radius:" + distance_sought unless @current_search.zip_code_radius.blank?
     unless  @build_search_query_string.blank? 
      @build_search_query_string = @build_search_query_string + "; "
    end
    @build_search_query_string = @build_search_query_string + "Item Date Range" + @current_search.start_date +  @current_search.start_date unless @current_search.start_date.blank? && @current_search.end_date.blank?
     unless  @build_search_query_string.blank? 
      @build_search_query_string = @build_search_query_string + "; "
    end
    
    
    @build_search_query_string = @build_search_query_string +  (@current_search.lender_or_borrower == 1 ? "Lender" : "Borrower") unless @current_search.lender_or_borrower.blank?
     unless  @build_search_query_string.blank? 
      @build_search_query_string = @build_search_query_string + "; "
    end
    unless @current_search.category_id.blank?
      @cat = Categories.find(:first, :conditions => ["category_id = ?", @current_search.category_id]) 
      if @cat
        @build_search_query_string = @build_search_query_string + "Category" + @cat.category_type
      end   
    end  
    session[:query_string] = @build_search_query_string 
    @borrowers = Borrowers.new
end

 def rapid_update_borrower_seeking
   session[:notice] = ''
    unless params[:borrowers].blank?
        @req = params[:borrowers]
        @borrowers = Borrowers.new(
          :user_id => 'NA',
          :describe_yourself => -1,
          :first_name => 'NA',
          :last_name => 'NA',
          :displayBorrowerName => 0,
          :address_line_1 => 'NA',
          :state_id=> @req[:state_id].to_s,
          :state_id_string=> @req[:state_id_string],
          :country_id=> @req[:country_id].to_s,
          :displayBorrowerAddress  => 0,
          :useWhichContactAddress => 0,
          :email_alternative=> @req[:email_alternative],
          :borrower_contact_by_email=> 2,
          :item_category_id => @req[:item_category_id].to_i,
          :item_description=> @req[:item_description],
          :item_condition_id=> @req[:item_condition_id].to_i,
          :other_item_category=> @req[:other_item_category],
          :item_model=> @req[:item_model],
          :item_count=> @req[:item_count].to_i,
          :goodwill=> @req[:goodwill].to_i,
          :age_18_or_more=>@req[:age_18_or_more].to_i,
          :is_active => @req[:is_active].to_i,
          :is_saved => @req[:is_saved].to_i,
          :is_community => @req[:is_community].to_i,
          :date_created => Time.now,
          :approved => 0)
         if @borrowers.save(:validate => false) 
         session[:notice] = "Your borrower's record has been saved."
         end
     end       
 end

 def b_list
      session[:notice] = ''
      session[:background] = true
 end

  def borrower_item_detail
    session[:background] = true
    unless params[:id].blank?
        
        @borrowers = Borrowers.find(:all, :conditions => ["borrower_item_id = ?", params[:id]])
        @borrowers = Borrowers.new if @borrowers.blank?
      else
        @borrowers = Borrowers.new
      end
  end
 
   def community_borrower_item_detail
     session[:background] = true
     unless params[:id].blank?
        session[:reuse] = (params['commit'] == 'reuse' ? true : false)
        session[:edit_record] = (params['commit'] == 'edit' ? true : false)
        @borrowers = Borrowers.find(:all, :conditions => ["borrower_item_id = ?", params[:id]])
        @borrowers = Borrowers.new if @borrowers.blank?
      else
        @borrowers = Borrowers.new
      end
 end


  def borrower_history

    ###  looking for :id and/or :commit: This method delegates to _offering if :commit
    session[:background] = true
    session[:notice] = ""
    @which_view = (session[:community_id].blank? ? "borrower_seeking" : "community_borrower_seeking" )
   
    if !(params[:commit].blank?) && params[:id]
         if params['commit'] == "edit"
          session[:reuse] = false
		session[:edit_record] = true
          redirect_to :action => @which_view, :commit => "edit", :id => params[:id]
         elsif params['commit'] == "reuse"
          session[:reuse] = true   
		session[:edit_record] = true

          redirect_to :action => @which_view, :commit => "reuse", :id => params[:id]
        end  
    else  
        @borrowers = Borrowers.find(:all, :readonly, :conditions => ["user_id = ? and is_active = 1", params[:id]]) 
        if @borrowers.blank?
          
          redirect_to  :controller => "borrower", :action => @which_view
        end
   end     
        
  end

  def delete_borrower_record
    session[:background] = true
    if params['commit'] == "delete"
      @l = Borrowers.update(params[:id], :is_active => 0,  :date_deleted => Time.now)
      @l.save
      @ld  = Borrowers.find(:all, :readonly => true, :conditions => ["user_id = ? and is_active = 1", session[:user_id]])
      unless  @ld.blank?
        redirect_to :action => "borrower_history", :id=> session[:user_id]  
      else
        session[:notice] = "Seems that you have deleted all your records.  Hope it is because you were able to borrow an item."
        redirect_to :controller => "home", :action => "items_listing"
      end
    end
  end

  def borrower_seeking
    
    if params[:id].blank?
    @borrowers = Borrowers.new
    else
      @borrowers = Borrowers.find(params[:id])
    end
  end
  
  def community_borrower_seeking
    
     if params[:id].blank?
        @borrowers = Borrowers.new
    else
        @borrowers = Borrowers.find(params[:id])
    end
  end
   
  def update_borrower_seeking
    session[:notice] = ''
    unless params[:borrowers].blank?
      if (params[:borrowers][:borrower_item_id].blank?)  ## then it is a new record

        @req = params[:borrowers]
        @useWhichContactAddress = (@req[:useWhichContactAddress].blank? ? 0: @req[:useWhichContactAddress].to_i)
        @hold_picture_file = @req[:item_image_upload]
        @borrowers = Borrowers.new(
          :user_id => session[:user_id],
          :describe_yourself =>  @req[:describe_yourself].to_i,
          :other_describe_yourself => @req[:other_describe_yourself],
          :organization_name => @req[:organization_name],
          :displayBorrowerOrganizationName => (@req[:displayBorrowerOrganizationName].blank? ? -1  : @req[:displayBorrowerOrganizationName].to_i),
          :first_name=> @req[:first_name],
          :mi=> @req[:mi],
          :displayBorrowerName => (@req[:displayBorrowerName].blank? ? -1 :@req[:displayBorrowerName].to_i) ,
          :displayBorrowerAddress => (@req[:displayBorrowerAddress].blank? ? -1 :@req[:displayBorrowerAddress].to_i) ,
          :last_name=>@req[:last_name],
          :address_line_1=> @req[:address_line_1],
          :address_line_2=> @req[:address_line_2],
          :postal_code=> @req[:postal_code],
          :city=> @req[:city],
          :province=> @req[:province],
          :state_id=> @req[:state_id].to_s,
          :state_id_string=> @req[:state_id_string],
          :country_id=> @req[:country_id].to_s,
          :useWhichContactAddress => @useWhichContactAddress,
          :address_line_1_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:address_line_1_alternative]: '') ,
          :address_line_2_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:address_line_2_alternative]: ''),
          :postal_code_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:postal_code_alternative]:''),
          :city_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:city_alternative]: ''),
          :province_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:province_alternative]: ''),
          :state_id_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:state_id_alternative]: '99'),
          :state_id_string_alternative=> @req[:state_id_string_alternative],
          :country_id_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:country_id_alternative]:'99'),
          :home_phone => @req[:home_phone],
          :public_display_home_phone=> (@req[:public_display_home_phone].blank? ? -1:@req[:public_display_home_phone].to_i) ,
          :cell_phone=> @req[:cell_phone],
          :public_display_cell_phone=>  (@req[:public_display_cell_phone].blank? ? -1: @req[:public_display_cell_phone].to_i) ,
          :alternative_phone=>@req[:alternative_phone],
          :public_display_alternative_phone=>(@req[:public_display_alternative_phone].blank? ? -1: @req[:public_alternative_cell_phone].to_i) ,
          :email_alternative=> @req[:email_alternative],
          :borrower_contact_by_email=> (@req[:borrower_contact_by_email].blank? ? -1:@req[:borrower_contact_by_email].to_i) ,
          :borrower_contact_by_home_phone=> @req[:borrower_contact_by_home_phone],
          :borrower_contact_by_cell_phone=> @req[:borrower_contact_by_cell_phone],
          :borrower_contact_by_alternative_phone=> @req[:borrower_contact_by_alternative_phone],
          :borrower_contact_by_Facebook=> @req[:borrower_contact_by_Facebook],
          :borrower_contact_by_LinkedIn=> @req[:borrower_contact_by_LinkedIn],
          :borrower_contact_by_Other_Social_Media=> @req[:borrower_contact_by_Other_Social_Media],
          :borrower_contact_by_Twitter=> @req[:borrower_contact_by_Twitter],
          :borrower_contact_by_Instagram=> @req[:borrower_contact_by_Instagram],
          :borrower_contact_by_Other_Social_Media_Access=> @req[:borrower_contact_by_Other_Social_Media_Access],
          :item_category_id => @req[:item_category_id].to_i,
          :item_description=> @req[:item_description],
          :item_condition_id=> @req[:item_condition_id].to_i,
          :other_item_category=> @req[:other_item_category],
          :notify_lenders=> (@req[:notify_lenders].blank? ? -1:@req[:notify_lenders].to_i) ,
          :item_model=> @req[:item_model],
          :item_count=> @req[:item_count].to_i,
          :item_image_caption=> @req[:item_image_caption],
          :goodwill=> @req[:goodwill].to_i,
          :age_18_or_more=>@req[:age_18_or_more].to_i,
          :is_active => @req[:is_active].to_i,
          :is_saved => @req[:is_saved].to_i,
          :is_community => (session[:community_name].blank? ? 0 : 1),
          :date_created => Time.now,
          :approved => 0)
        @shouldvalidate = (@req[:is_saved].to_i == 1 ? true : false)
        if @borrowers.save(:validate => @shouldvalidate) && @borrowers.errors.empty?

          unless @hold_picture_file.blank?
            @img =  Itemimages.new(:borrower_item_id => @borrowers.borrower_item_id,
              :lender_item_id => '',
              :item_image_upload=> @hold_picture_file,
              :item_image_caption=> @req[:item_image_caption],
              :date_created =>Time.now,
              :is_active => 1)
            @img.save
          end
          redirect_to :action => 'borrower_history', :id=> session[:user_id]
        else
          return false
        end

      elsif (!params[:borrowers][:borrower_item_id].blank?)
        ## do update
        @ltmp = Borrowers.find(:first, :conditions => ["borrower_item_id = ?",params[:borrowers][:borrower_item_id] ])
        @req = params[:borrowers]
        @useWhichContactAddress = (@req[:useWhichContactAddress].blank? ? 0: @req[:useWhichContactAddress].to_i)
        @hold_picture_file = @req[:item_image_upload]
        @myupdatehash = Hash.new
        @myupdatehash = [:describe_yourself =>  @req[:describe_yourself].to_i,
          :other_describe_yourself => @req[:other_describe_yourself],
          :organization_name => @req[:organization_name],
          :displayBorrowerOrganizationName => (@req[:displayBorrowerOrganizationName].blank? ? -1  : @req[:displayBorrowerOrganizationName].to_i),
          :first_name=> @req[:first_name],
          :mi=> @req[:mi],
          :displayBorrowerName => (@req[:displayBorrowerName].blank? ? -1 :@req[:displayBorrowerName].to_i) ,
          :displayBorrowerAddress => (@req[:displayBorrowerAddress].blank? ? -1 :@req[:displayBorrowerAddress].to_i) ,
          :last_name=>@req[:last_name],
          :address_line_1=> @req[:address_line_1],
          :address_line_2=> @req[:address_line_2],
          :postal_code=> @req[:postal_code],
          :city=> @req[:city],
          :province=> @req[:province],
          :state_id=> @req[:state_id].to_s,
          :state_id_string=> @req[:state_id_string],
          :country_id=> @req[:country_id].to_s,
          :useWhichContactAddress => @useWhichContactAddress,
          :address_line_1_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:address_line_1_alternative]: '') ,
          :address_line_2_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:address_line_2_alternative]: ''),
          :postal_code_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:postal_code_alternative]:''),
          :city_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:city_alternative]: ''),
          :province_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:province_alternative]: ''),
          :state_id_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:state_id_alternative]: '99'),
          :state_id_string_alternative=> @req[:state_id_string_alternative],
          :country_id_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:country_id_alternative]:'99'),
          :home_phone => @req[:home_phone],
          :public_display_home_phone=> (@req[:public_display_home_phone].blank? ? -1:@req[:public_display_home_phone].to_i) ,
          :cell_phone=> @req[:cell_phone],
          :public_display_cell_phone=>  (@req[:public_display_cell_phone].blank? ? -1: @req[:public_display_cell_phone].to_i) ,
          :alternative_phone=>@req[:alternative_phone],
          :public_display_alternative_phone=>(@req[:public_display_alternative_phone].blank? ? -1: @req[:public_alternative_cell_phone].to_i) ,
          :email_alternative=> @req[:email_alternative],
          :borrower_contact_by_email=> (@req[:borrower_contact_by_email].blank? ? -1:@req[:borrower_contact_by_email].to_i) ,
          :borrower_contact_by_home_phone=> @req[:borrower_contact_by_home_phone],
          :borrower_contact_by_cell_phone=> @req[:borrower_contact_by_cell_phone],
          :borrower_contact_by_alternative_phone=> @req[:borrower_contact_by_alternative_phone],
          :borrower_contact_by_Facebook=> @req[:borrower_contact_by_Facebook],
          :borrower_contact_by_LinkedIn=> @req[:borrower_contact_by_LinkedIn],
          :borrower_contact_by_Other_Social_Media=> @req[:borrower_contact_by_Other_Social_Media],
          :borrower_contact_by_Twitter=> @req[:borrower_contact_by_Twitter],
          :borrower_contact_by_Instagram=> @req[:borrower_contact_by_Instagram],
          :borrower_contact_by_Other_Social_Media_Access=> @req[:borrower_contact_by_Other_Social_Media_Access],
          :notify_lenders=> (@req[:notify_lenders].blank? ? -1:@req[:notify_lenders].to_i) ,
          :item_category_id => @req[:item_category_id].to_i,
          :item_description=> @req[:item_description],
          :item_condition_id=> @req[:item_condition_id].to_i,
          :other_item_category=> @req[:other_item_category],
          :item_model=> @req[:item_model],
          :item_count=> @req[:item_count].to_i,
          :item_image_caption=> @req[:item_image_caption],
          :goodwill=> @req[:goodwill].to_i,
          :age_18_or_more=>@req[:age_18_or_more].to_i,
          :is_active => @req[:is_active].to_i,
          :is_saved => @req[:is_saved].to_i,
          :is_community => (session[:community_name].blank? ? 0 : 1),
          :date_updated => Time.now,
          :approved => 0]


        if @ltmp.update_attributes(@myupdatehash[0])

          unless (@hold_picture_file.blank?)
            @img = Itemimages.find(:first, :conditions => ["borrower_item_id = ?", @ltmp.borrower_item_id])
            @myupdatehash = Hash.new
            @myupdatehash = [:borrower_item_id => @ltmp.borrower_item_id,
              :lender_item_id => '',
              :item_image_upload=> @hold_picture_file,
              :item_image_caption=> @req[:item_image_caption],
              :date_created => Time.now,
              :date_updated => Time.now,
              :is_active => 1]
            @img.update_attributes(@myupdatehash[0])
            @img.save
          end
          redirect_to :action => 'borrower_history', :id=> session[:user_id]
        else
          return false
        end
      end
    else
      session[:notice]  = "Echo Market error in updating borrower record"
      redirect_to home_items_listing_url
    end
  end

end