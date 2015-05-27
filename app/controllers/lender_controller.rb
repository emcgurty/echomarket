class LenderController < ApplicationController

 def rapid_lender_offering
    session[:notice] = ''
    session[:background] = true 
    if params[:lenders]
		create
    else
   @lender = Lender.new
	end
 
end

 def create
    session[:notice] = ''
    unless params[:lenders].blank?
        @req = params[:lenders]
        @lender = Lender.new(
          :user_id => 'NA',
          :describe_yourself => -1,
          :first_name => 'NA',
          :last_name => 'NA',
          :displayLenderName => 0,
          :displayLenderAddress  => 0,
          :useWhichContactAddress => 0,
          :email_alternative=> @req[:email_alternative],
          :borrower_contact_by_email=> 2,
          :category_id => @req[:category_id].to_i,
          :item_description=> @req[:item_description],
          :item_condition_id=> @req[:item_condition_id].to_i,
          :other_item_category=> @req[:other_item_category],
          :item_model=> @req[:item_model],
          :item_count=> @req[:item_count].to_i,
          :goodwill=> @req[:goodwill].to_i,
          :age_18_or_more=>@req[:age_18_or_more].to_i,
          :is_active => @req[:is_active].to_i,
          :is_community => @req[:is_community].to_i,
          :date_created => Time.now,
          :approved => 1,
          :remote_ip => @req[:remote_ip])
         if @lender.save(:validate => false) 
         @un = 'rapid_' + @lender.item_description
         @user = User.new(:username => @un, :email => @lender.email_alternative, :created_at => Time.now, 
                    :remote_ip => @lender.remote_ip, :user_alias => @un, :approved => 1, :is_rapid => 1, :user_type => 'lender', :activated_at => Time.now, :activation_code => '', :password => get_random_password)        
         @user.save(:validate => false)
         @myupdatehash = [:user_id => @user.user_id]
         if @lender.update_attributes(@myupdatehash[0])
         Notifier.notify_rapid(@user).deliver 
         session[:notice] = "Your lender's record has been saved."
         redirect_to  :controller => "search", :action => 'item_search'
         end 
         end
   end
   
 end
 
  def l_list
  session[:notice] = ''
      session[:background] = true
      if session[:community_name].blank? 
        my_sql_string = "select lenders.*, item_conditions.condition, categories.category_type, item_images.*  
              FROM lenders
              INNER JOIN categories ON categories.id = lenders.category_id
              INNER JOIN item_conditions ON item_conditions.id = lenders.item_condition_id
              INNER JOIN item_images ON item_images.lender_id = lenders.id
              WHERE (lenders.is_active=1 and (lenders.is_community = 0  OR lenders.is_community = 3))
              ORDER BY categories.category_type ASC, lenders.date_created ASC"
              
        @lender = Lender.find_by_sql my_sql_string       
                
      else 
          
          my_sql_string = "select borrowers.*, item_conditions.condition, categories.category_type, item_images.*  
              FROM borrowers
              INNER JOIN categories ON categories.id = lenders.category_id
              INNER JOIN item_conditions ON item_conditions.id = lenders.item_condition_id
              INNER JOIN item_images ON item_images.lender_id = lenders.id
              WHERE (lenders.is_active=1 AND  lenders.is_community = 1 AND lenders.user_id =  "
          my_sql_string =  my_sql_string + session[:user_id]
          my_sql_string =  my_sql_string + " ) ORDER BY categories.category_type ASC, lenders.date_created ASC" 
          @lender = Lender.find_by_sql my_sql_string
      
      end 
        if @lender.blank?
          session[:notice] = "Sorry, no Lenders records yet."
          redirect_to  :controller => "search", :action => 'item_search'
      end
      
  end

  def lender_item_detail
      session[:background] = true
      unless params[:id].blank?
        session[:reuse] = (params['commit'] == 'reuse' ? true : false)
        @lender = Lender.find(:all, :readonly, :conditions => ["id = ?", params[:id]])
     
      end
      
      if @lender.blank? || params[:id].blank?
          session[:notice]  = "The lender item you were seeking does not exist in the Echo Market database."  
          redirect_to home_items_listing_url
      end 
      
      
  end
   
   def community_lender_item_detail
      session[:background] = true
      unless params[:id].blank?
        session[:reuse] = (params['commit'] == 'reuse' ? true : false)
	      session[:edit_record] = (params['commit'] == 'edit' ? true : false)
        @lender = Lender.find(:all, :readonly, :conditions => ["id = ?", params[:id]])
      end
      
      if @lender.blank? || params[:id].blank?
          session[:notice]  = "The Community lender item you were seeking does not exist in the Echo Market database."  
          redirect_to home_items_listing_url
      end 
  end


  def lender_history

    ###  looking for :id and/or :commit: This method delegates to _offering if :commit
    session[:background] = true
    session[:notice] = ""
    @which_view = (session[:community_id].blank? ? "lender_offering" : "community_lender_offering" )
   
    if !(params['commit'].blank?) && params[:id]
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
         my_sql_string = "select lenders.*, item_conditions.condition, categories.category_type  
              FROM lenders
              INNER JOIN categories ON categories.id = lenders.category_id
              INNER JOIN item_conditions ON item_conditions.id = lenders.item_condition_id
              WHERE (lenders.is_active=1 and lenders.user_id = "
        my_sql_string = my_sql_string +    params[:id]
        my_sql_string = my_sql_string + " ) ORDER BY categories.category_type ASC, lenders.date_created ASC "    
          
        @lender = Lender.find_by_sql my_sql_string
 
        if @lender.blank?
          redirect_to  :controller => "lender", :action => @which_view 
        else
           @lender 
       end
   end     
        
  end

 def delete_lender_record
     session[:background] = true
     if params['commit'] == "delete"
      @l = Lender.update(params[:id], :is_active => 0,  :date_deleted => Time.now)
      @l.save
      @ld  = Lender.find(:all, :readonly => true, :conditions => ["user_id = ? and is_active = 1", session[:user_id]])
     unless  @ld.blank?
        redirect_to :action => "lender_history", :commit => "",  :id=> session[:user_id]  
      else
        session[:notice] = "Seems that you have deleted all your records.  Hope it is because your item(s) have been borrowed."
        redirect_to :controller => "home", :action => "items_listing"
      end
    end
  end

  def lender_offering
     session[:no_border] = true

    if params[:id].blank?
      @lender = Lender.new
    else
      @lender = Lender.find(:all, :conditions => ["id = ?", params[:id]])
      if @lender.blank?
        @lender = Lender.new
        
      end
    end
  end
  
  def community_lender_offering
    session[:no_border] = true

     if params[:id].blank?
    @lender = Lender.new
    else
      @lender = Lender.find(:all, :conditions => ["lender_id = ?", params[:id]])
      if @lender.blank?
        @lender = Lender.new
      end
    end
  end
  
  def update_lender_offering
    session[:notice] = ''
    unless params[:lenders].blank?
      if (params[:lenders][:id].blank?)  ## then it is a new record

        @req = params[:lenders]

        @useWhichContactAddress = (@req[:useWhichContactAddress].blank? ? 0: @req[:useWhichContactAddress].to_i)
        @hold_picture_file = @req[:item_image_upload]
        @lender = Lender.new(
          :user_id => session[:user_id],
          :describe_yourself =>  @req[:describe_yourself].to_i,
          :other_describe_yourself => @req[:other_describe_yourself],
          :organization_name => @req[:organization_name],
          :displayLenderOrganizationName => (@req[:displayLenderOrganizationName].blank? ? -1  : @req[:displayLenderOrganizationName].to_i),
          :first_name=> @req[:first_name],
          :mi=> @req[:mi],
          :displayLenderName => (@req[:displayLenderName].blank? ? -1 :@req[:displayLenderName].to_i) ,
          :displayLenderAddress => (@req[:displayLenderAddress].blank? ? -1 :@req[:displayLenderAddress].to_i) ,
          :last_name=>@req[:last_name],
          :address_line_1=> @req[:address_line_1],
          :address_line_2=> @req[:address_line_2],
          :postal_code=> @req[:postal_code],
          :city=> @req[:city],
          :province=> @req[:province],
          :us_state_id=> (@req[:us_state_id].blank? ? @req[:us_state_id] : '99'),
          :us_state_id=> @req[:us_state_id],
          :country_id=> @req[:country_id],
          :useWhichContactAddress => @useWhichContactAddress,
          :address_line_1_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:address_line_1_alternative]: '') ,
          :address_line_2_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:address_line_2_alternative]: ''),
          :postal_code_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:postal_code_alternative]:''),
          :city_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:city_alternative]: ''),
          :province_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:province_alternative]: ''),
          :us_state_id_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:us_state_id_alternative]: '99'),
          :us_state_id_alternative => @req[:us_state_id_alternative],
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
          :b_comes_to_which_address=> (@req[:b_comes_to_which_address].blank? ? -1:@req[:b_comes_to_which_address].to_i),
          :meetBorrowerAtAgreedL2B=> (@req[:meetBorrowerAtAgreedL2B].blank? ? -1:@req[:meetBorrowerAtAgreedL2B].to_i),
          :willDeliverToBorrowerPreferredL2B=> (@req[:willDeliverToBorrowerPreferredL2B].blank? ? -1:@req[:willDeliverToBorrowerPreferredL2B].to_i),
          :thirdPartyPresenceL2B=> (@req[:thirdPartyPresenceL2B].blank? ? -1:@req[:thirdPartyPresenceL2B].to_i),
          :b_returns_to_which_address=>(@req[:b_returns_to_which_address].blank? ? -1:@req[:b_returns_to_which_address].to_i),
          :meetBorrowerAtAgreedB2L=> (@req[:meetBorrowerAtAgreedB2L].blank? ? -1:@req[:meetBorrowerAtAgreedB2L].to_i),
          :willPickUpPreferredLocationB2L=>(@req[:willPickUpPreferredLocationB2L].blank? ? -1:@req[:willPickUpPreferredLocationB2L].to_i),
          :thirdPartyPresenceB2L=>(@req[:agreedThirdPartyChoiceB2L=].blank? ? -1:@req[:agreedThirdPartyChoiceB2L=].to_i),
          :agreedThirdPartyChoiceB2L=>(@req[:agreedThirdPartyChoiceB2L].blank? ? -1:@req[:agreedThirdPartyChoiceB2L=].to_i),
          :agreedThirdPartyChoiceL2B=>(@req[:agreedThirdPartyChoiceL2B].blank? ? -1:@req[:agreedThirdPartyChoiceL2B=].to_i),
          :lenderThirdPartyChoiceB2L=>(@req[:lenderThirdPartyChoiceB2L].blank? ? -1:@req[:lenderThirdPartyChoiceB2L=].to_i),
          :lenderThirdPartyChoiceL2B=>(@req[:lenderThirdPartyChoiceL2B].blank? ? -1:@req[:lenderThirdPartyChoiceL2B=].to_i),
          :borrower_contact_by_Facebook=> @req[:borrower_contact_by_Facebook],
          :borrower_contact_by_LinkedIn=> @req[:borrower_contact_by_LinkedIn],
          :borrower_contact_by_Other_Social_Media=> @req[:borrower_contact_by_Other_Social_Media],
          :borrower_contact_by_Twitter=> @req[:borrower_contact_by_Twitter],
          :borrower_contact_by_Instagram=> @req[:borrower_contact_by_Instagram],
          :borrower_contact_by_Other_Social_Media_Access=> @req[:borrower_contact_by_Other_Social_Media_Access],
          :category_id => @req[:category_id].to_i,
          :item_description=> @req[:item_description],
          :item_condition_id=> @req[:item_condition_id].to_i,
          :other_item_category=> @req[:other_item_category],
          :notify_borrowers=> (@req[:notify_borrowers].blank? ? -1:@req[:notify_borrowers].to_i) ,
          :item_model=> @req[:item_model],
          :item_count=> @req[:item_count].to_i,
          :item_image_caption=> @req[:item_image_caption],
          :security_deposit=> (@req[:security_deposit].blank? ? -1:@req[:security_deposit].to_i) ,
          :security_deposit_amount=> @req[:security_deposit_amount] ,
          :for_free=> (@req[:for_free].blank? ? -1:@req[:for_free].to_i) ,
          :small_fee=> (@req[:small_fee].blank? ? -1:@req[:small_fee].to_i) ,
          :small_fee_amount=> @req[:small_fee_amount],
          :available_for_purchase=> (@req[:available_for_purchase].blank? ? -1:@req[:available_for_purchase].to_i) ,
          :available_for_purchase_amount=> @req[:available_for_purchase_amount],
          :donate_anonymous => (@req[:donate_anonymous].blank? ? -1:@req[:donate_anonymous].to_i) ,
          :available_for_donation => (@req[:available_for_donation].blank? ? -1:@req[:available_for_donation].to_i) ,
          :trade=> (@req[:trade].blank? ? -1: @req[:trade].to_i),
          :trade_item=> @req[:trade_item],
          :agreed_number_of_days=>(@req[:agreed_number_of_days].blank? ? -1:@req[:agreed_number_of_days].to_i),
          :agreed_number_of_hours=>(@req[:agreed_number_of_hours].blank? ? -1:@req[:agreed_number_of_hours].to_i),
          :indefinite_duration=>(@req[:indefinite_duration].blank? ? -1:@req[:indefinite_duration].to_i),
          :present_during_borrowing_period=>(@req[:present_during_borrowing_period].blank? ? -1:@req[:present_during_borrowing_period].to_i),
          :entire_period =>(@req[:entire_period].blank? ? -1:@req[:entire_period].to_i),
          :partial_period =>(@req[:partial_period ].blank? ? -1:@req[:partial_period ].to_i),
          :provide_proper_use_training =>(@req[:provide_proper_use_training ].blank? ? -1:@req[:provide_proper_use_training ].to_i),
          :specific_conditions=> @req[:specific_conditions],
          :goodwill=> @req[:goodwill].to_i,
          :age_18_or_more=>@req[:age_18_or_more].to_i,
          :is_active => @req[:is_active].to_i,
          :is_community => (session[:community_name].blank? ? 0 : 1),
          :date_created => Time.now,
          :approved => 0)
       
        if @lender.save(:validate => true) && @lender.errors.empty?

          unless @hold_picture_file.blank?
            @img =  Itemimage.new(:lender_id => @lender.lender_id,
              :borrower_id => '',
              :item_image_upload=> @hold_picture_file,
              :item_image_caption=> @req[:item_image_caption],
              :date_created =>Time.now,
              :is_active => 1)
            @img.save
          end
          
          redirect_to  :action => 'lender_history', :id => session[:user_id], :commit => ""
        else
          
          return false
        end
      
      elsif (!params[:lenders][:lender_id].blank?)
        ## do update
        @ltmp = Lender.find(:first, :conditions => ["lender_id = ?",params[:lenders][:lender_id] ])
        @req = params[:lenders]
        @useWhichContactAddress = (@req[:useWhichContactAddress].blank? ? 0: @req[:useWhichContactAddress].to_i)
        @hold_picture_file = @req[:item_image_upload]
        @myupdatehash = Hash.new
        @myupdatehash = [:describe_yourself =>  @req[:describe_yourself].to_i,
          :other_describe_yourself => @req[:other_describe_yourself],
          :organization_name => @req[:organization_name],
          :displayLenderOrganizationName => (@req[:displayLenderOrganizationName].blank? ? -1  : @req[:displayLenderOrganizationName].to_i),
          :first_name=> @req[:first_name],
          :mi=> @req[:mi],
          :displayLenderName => (@req[:displayLenderName].blank? ? -1 :@req[:displayLenderName].to_i) ,
          :displayLenderAddress => (@req[:displayLenderAddress].blank? ? -1 :@req[:displayLenderAddress].to_i) ,
          :last_name=>@req[:last_name],
          :address_line_1=> @req[:address_line_1],
          :address_line_2=> @req[:address_line_2],
          :postal_code=> @req[:postal_code],
          :city=> @req[:city],
          :province=> @req[:province],
          :us_state_id=> (@req[:us_state_id].blank? ? @req[:us_state_id] : '99'),
          :us_state_id=> @req[:us_state_id],
          :country_id=> @req[:country_id],
          :useWhichContactAddress => @useWhichContactAddress,
          :address_line_1_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:address_line_1_alternative]: '') ,
          :address_line_2_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:address_line_2_alternative]: ''),
          :postal_code_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:postal_code_alternative]:''),
          :city_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:city_alternative]: ''),
          :province_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:province_alternative]: ''),
          :us_state_id_alternative => ((@useWhichContactAddress == 2 || @useWhichContactAddress == 1) ? @req[:us_state_id_alternative]: '99'),
          :us_state_id_alternative=> @req[:us_state_id_alternative],
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
          :b_comes_to_which_address=> (@req[:b_comes_to_which_address].blank? ? -1:@req[:b_comes_to_which_address].to_i),
          :meetBorrowerAtAgreedL2B=> (@req[:meetBorrowerAtAgreedL2B].blank? ? -1:@req[:meetBorrowerAtAgreedL2B].to_i),
          :willDeliverToBorrowerPreferredL2B=> (@req[:willDeliverToBorrowerPreferredL2B].blank? ? -1:@req[:willDeliverToBorrowerPreferredL2B].to_i),
          :thirdPartyPresenceL2B=> (@req[:thirdPartyPresenceL2B].blank? ? -1:@req[:thirdPartyPresenceL2B].to_i),
          :b_returns_to_which_address=>(@req[:b_returns_to_which_address].blank? ? -1:@req[:b_returns_to_which_address].to_i),
          :meetBorrowerAtAgreedB2L=> (@req[:meetBorrowerAtAgreedB2L].blank? ? -1:@req[:meetBorrowerAtAgreedB2L].to_i),
          :agreedThirdPartyChoiceB2L=>(@req[:agreedThirdPartyChoiceB2L].blank? ? -1:@req[:agreedThirdPartyChoiceB2L=].to_i),
          :agreedThirdPartyChoiceL2B=>(@req[:agreedThirdPartyChoiceL2B].blank? ? -1:@req[:agreedThirdPartyChoiceL2B=].to_i),
          :lenderThirdPartyChoiceB2L=>(@req[:lenderThirdPartyChoiceB2L].blank? ? -1:@req[:lenderThirdPartyChoiceB2L=].to_i),
          :lenderThirdPartyChoiceL2B=>(@req[:lenderThirdPartyChoiceL2B].blank? ? -1:@req[:lenderThirdPartyChoiceL2B=].to_i),
          :willPickUpPreferredLocationB2L=>(@req[:willPickUpPreferredLocationB2L].blank? ? -1:@req[:willPickUpPreferredLocationB2L].to_i),
          :thirdPartyPresenceB2L=>(@req[:thirdPartyPresenceB2L].blank? ? -1:@req[:thirdPartyPresenceB2L].to_i),
          :borrower_contact_by_Facebook=> @req[:borrower_contact_by_Facebook],
          :borrower_contact_by_LinkedIn=> @req[:borrower_contact_by_LinkedIn],
          :borrower_contact_by_Other_Social_Media=> @req[:borrower_contact_by_Other_Social_Media],
          :borrower_contact_by_Twitter=> @req[:borrower_contact_by_Twitter],
          :borrower_contact_by_Instagram=> @req[:borrower_contact_by_Instagram],
          :borrower_contact_by_Other_Social_Media_Access=> @req[:borrower_contact_by_Other_Social_Media_Access],
          :notify_borrowers=> (@req[:notify_borrowers].blank? ? -1:@req[:notify_borrowers].to_i) ,
          :category_id => @req[:category_id].to_i,
          :item_description=> @req[:item_description],
          :item_condition_id=> @req[:item_condition_id].to_i,
          :other_item_category=> @req[:other_item_category],
          :item_model=> @req[:item_model],
          :item_count=> @req[:item_count].to_i,
          :item_image_caption=> @req[:item_image_caption],
          :security_deposit=> (@req[:security_deposit].blank? ? -1:@req[:security_deposit].to_i) ,
          :security_deposit_amount=> @req[:security_deposit_amount] ,
          :for_free=> (@req[:for_free].blank? ? -1:@req[:for_free].to_i) ,
          :small_fee=> (@req[:small_fee].blank? ? -1:@req[:small_fee].to_i) ,
          :small_fee_amount=> @req[:small_fee_amount],
          :available_for_purchase=> (@req[:available_for_purchase].blank? ? -1:@req[:available_for_purchase].to_i) ,
          :available_for_purchase_amount=> @req[:available_for_purchase_amount],
          :donate_anonymous => (@req[:donate_anonymous].blank? ? -1:@req[:donate_anonymous].to_i) ,
          :available_for_donation => (@req[:available_for_donation].blank? ? -1:@req[:available_for_donation].to_i) ,
          :trade=> (@req[:trade].blank? ? -1: @req[:trade].to_i),
          :trade_item=> @req[:trade_item],
          :agreed_number_of_days=>(@req[:agreed_number_of_days].blank? ? -1:@req[:agreed_number_of_days].to_i),
          :agreed_number_of_hours=>(@req[:agreed_number_of_hours].blank? ? -1:@req[:agreed_number_of_hours].to_i),
          :indefinite_duration=>(@req[:indefinite_duration].blank? ? -1:@req[:indefinite_duration].to_i),
          :present_during_borrowing_period=>(@req[:present_during_borrowing_period].blank? ? -1:@req[:present_during_borrowing_period].to_i),
          :entire_period =>(@req[:entire_period].blank? ? -1:@req[:entire_period].to_i),
          :partial_period =>(@req[:partial_period ].blank? ? -1:@req[:partial_period ].to_i),
          :provide_proper_use_training =>(@req[:provide_proper_use_training ].blank? ? -1:@req[:provide_proper_use_training ].to_i),
          :specific_conditions=> @req[:specific_conditions],
          :goodwill=> @req[:goodwill].to_i,
          :age_18_or_more=>@req[:age_18_or_more].to_i,
          :is_active => @req[:is_active].to_i,
          :is_community => (session[:community_name].blank? ? 0 : 1),
          :date_updated => Time.now,
          :approved => 0]

    
        @ltmp.update_attributes(@myupdatehash[0])
        if @ltmp.save(:validate => true) && @ltmp.errors.empty?
          
          unless (@hold_picture_file.blank?)
            @img = Itemimage.find(:first, :conditions => ["lender_id = ?", @ltmp.lender_id])
            @myupdatehash = Hash.new
            @myupdatehash = [:lender_id => @ltmp.lender_id,
              :borrower_id => '',
              :item_image_upload=> @hold_picture_file,
              :item_image_caption=> @req[:item_image_caption],
              :date_created => Time.now,
              :date_updated => Time.now,
              :is_active => 1]
            @img.update_attributes(@myupdatehash[0])
            @img.save
          end
          
          redirect_to  :action => 'lender_history', :id => session[:user_id], :commit => ""
        else
          
          return false
        end
      end
    else
     session[:notice]  = "Echo Market error in updating lender record"
      redirect_to home_items_listing_url
     end
  end
  
    
  def get_random_password
    length = 8
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    @id = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @id
  end

end

  