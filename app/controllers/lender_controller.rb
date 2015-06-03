class LenderController < ApplicationController


def rapid_lender_offering
    
    session[:background] = true 
    if params[:lender]
      if create
         redirect_to home_items_listing_url
      end
    else
      @lender = Lender.new
      
     respond_to do |f|
      f.html
    end
    end
    

end

 
 def l_list
      session[:notice] = ''
      session[:background] = true
      if session[:community_name].blank? 
         @lender = Lender.joins(:category, :item_condition, :item_images).select(["lenders.*", "lenders.id AS b_id", "categories.category_type", "item_conditions.condition", "item_images.*"]).where([" lenders.is_active=1 AND (lenders.is_community = 0  OR lenders.is_community = 3 )"]).order(["categories.category_type ASC, lenders.date_created ASC "])
      
      else 
          
         where_clause = " lenders.is_active= 1 AND lenders.is_community = 1  AND lenders.user_id  =  '#{session[:user_id]}'" 
         @lender = Lender.joins(:category, :item_condition, :item_images).select(["lenders.*", "lenders.id AS b_id", "categories.category_type", "item_conditions.condition", "item_images.*"]).where([where_clause]).order(["categories.category_type ASC, lenders.date_created ASC "])
                                 
      end 
      
     
    
     if @lender.blank?
          
          if session[:user_id].blank?
            session[:notice] = "Sorry, no lenders records have been created."
            redirect_to  home_items_listing_url
          else
            session[:notice] = "Sorry, no lenders records have been created. Perhaps you would like to create one now."
            redirect_to  lender_offering_url
          end    
    
      end

     @lender  
        
 end

 def lender_item_detail
   where_clause = ""
    session[:background] = true
    unless params[:id].blank?
    
              if session[:community_name].blank?
                 where_clause = " lenders.id =  #{params[:id]}"
                 
              else
                 where_clause = " lenders.id = '#{params[:id]}' AND lenders.user_id = '#{session[:user_id]}'" 
                 
              end 
                                      
                   @lender = Lender.joins(:category, :item_condition, :item_images, :contact_describe).select(["contact_describes.borrower_or_lender_text", "lenders.*", "lenders.id AS b_id",   "categories.category_type", "item_conditions.condition", 
                    "item_images.item_image_caption", "item_images.image_file_name"]).where([where_clause]).order(["categories.category_type ASC, lenders.date_created ASC "])
                  
     
    end
    if @lender.blank?
          session[:notice]  = "The lender item you offered does not exist in the Echo Market database."  
          redirect_to home_items_listing_url
     end 
  
     
       @lender
  end
 
  
  def lender_history

    ###  looking for :id and/or :commit: This method delegates to _offering if :commit
    session[:background] = true
    session[:notice] = ""
    @which_view = (session[:community_id].blank? ? "lender_offering" : "community_lender_offering" )
   
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
        
         @lender = Lender.joins(:category, :item_condition).select(["lenders.*", "categories.category_type", "item_conditions.condition"]).where([" lenders.is_active = 1 AND lenders.user_id = ?", params[:id]]).order(["categories.category_type ASC, lenders.date_created ASC "])
   
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
        redirect_to :action => "lender_history", :id=> session[:user_id]  
      else
        session[:notice] = "Seems that you have deleted all your records.  Hope it is because you were able to lend an item."
        redirect_to :controller => "home", :action => "items_listing"
      end
    end
  end

  def lender_offering
    
    session[:no_border] = true
    if params[:lender]
      if update_lender_offering
        redirect_to :action => 'lender_history', :id=> session[:user_id]
      else
         @lender
      end
      
    else
      if params[:id].blank?
       session[:edit_record] = false 
       @lender = Lender.new
      else
        @lender = Lender.find(params[:id])
      end
    end
    
  end
  
    def community_lender_offering
    
 
    session[:no_border] = true
    if params[:lender]
      if update_lender_offering
        redirect_to :action => 'lender_history', :id=> session[:user_id]
      else
         @lender
      end
      
    else
      if params[:id].blank?
       session[:edit_record] = false 
       @lender = Lender.new
      else
        @lender = Lender.find(params[:id])
      end
    end
    
  end
  
   
 protected  
   
  def update_lender_offering
    session[:notice] = ''
    unless params[:lender].blank?
      if (params[:lender][:id].blank?)  ## then it is a new record
          
        @useWhichContactAddress = (params[:lender][:useWhichContactAddress].blank? ? 0: params[:lender][:useWhichContactAddress].to_i)
        @myupdatehash = Hash.new
        @myupdatehash = [
          :user_id => session[:user_id],
          :contact_describe_id =>  params[:lender][:contact_describe_id].to_i,
          :other_describe_yourself => params[:lender][:other_describe_yourself],
          :organization_name => params[:lender][:organization_name],
          :displayLenderOrganizationName => (params[:lender][:displayLenderOrganizationName].blank? ? -1  : params[:lender][:displayLenderOrganizationName].to_i),
          :first_name=> params[:lender][:first_name],
          :mi=> params[:lender][:mi],
          :displayLenderName => (params[:lender][:displayLenderName].blank? ? -1 :params[:lender][:displayLenderName].to_i) ,
          :displayLenderAddress => (params[:lender][:displayLenderAddress].blank? ? -1 :params[:lender][:displayLenderAddress].to_i) ,
          :last_name=>params[:lender][:last_name],
          :useWhichContactAddress => @useWhichContactAddress,
          :home_phone => params[:lender][:home_phone],
          :public_display_home_phone=> (params[:lender][:public_display_home_phone].blank? ? -1:params[:lender][:public_display_home_phone].to_i) ,
          :cell_phone=> params[:lender][:cell_phone],
          :public_display_cell_phone=>  (params[:lender][:public_display_cell_phone].blank? ? -1: params[:lender][:public_display_cell_phone].to_i) ,
          :alternative_phone=>params[:lender][:alternative_phone],
          :public_display_alternative_phone=>(params[:lender][:public_display_alternative_phone].blank? ? -1: params[:lender][:public_alternative_cell_phone].to_i) ,
          :email_alternative=> params[:lender][:email_alternative],
          :borrower_contact_by_email=> (params[:lender][:borrower_contact_by_email].blank? ? -1:params[:lender][:borrower_contact_by_email].to_i) ,
          :borrower_contact_by_home_phone=> params[:lender][:borrower_contact_by_home_phone],
          :borrower_contact_by_cell_phone=> params[:lender][:borrower_contact_by_cell_phone],
          :borrower_contact_by_alternative_phone=> params[:lender][:borrower_contact_by_alternative_phone],
          :b_comes_to_which_address=> (params[:lender][:b_comes_to_which_address].blank? ? -1:params[:lender][:b_comes_to_which_address].to_i),
          :meetBorrowerAtAgreedL2B=> (params[:lender][:meetBorrowerAtAgreedL2B].blank? ? -1:params[:lender][:meetBorrowerAtAgreedL2B].to_i),
          :willDeliverToBorrowerPreferredL2B=> (params[:lender][:willDeliverToBorrowerPreferredL2B].blank? ? -1:params[:lender][:willDeliverToBorrowerPreferredL2B].to_i),
          :thirdPartyPresenceL2B=> (params[:lender][:thirdPartyPresenceL2B].blank? ? -1:params[:lender][:thirdPartyPresenceL2B].to_i),
          :b_returns_to_which_address=>(params[:lender][:b_returns_to_which_address].blank? ? -1:params[:lender][:b_returns_to_which_address].to_i),
          :meetBorrowerAtAgreedB2L=> (params[:lender][:meetBorrowerAtAgreedB2L].blank? ? -1:params[:lender][:meetBorrowerAtAgreedB2L].to_i),
          :willPickUpPreferredLocationB2L=>(params[:lender][:willPickUpPreferredLocationB2L].blank? ? -1:params[:lender][:willPickUpPreferredLocationB2L].to_i),
          :thirdPartyPresenceB2L=>(params[:lender][:agreedThirdPartyChoiceB2L=].blank? ? -1:params[:lender][:agreedThirdPartyChoiceB2L=].to_i),
          :agreedThirdPartyChoiceB2L=>(params[:lender][:agreedThirdPartyChoiceB2L].blank? ? -1:params[:lender][:agreedThirdPartyChoiceB2L=].to_i),
          :agreedThirdPartyChoiceL2B=>(params[:lender][:agreedThirdPartyChoiceL2B].blank? ? -1:params[:lender][:agreedThirdPartyChoiceL2B=].to_i),
          :lenderThirdPartyChoiceB2L=>(params[:lender][:lenderThirdPartyChoiceB2L].blank? ? -1:params[:lender][:lenderThirdPartyChoiceB2L=].to_i),
          :lenderThirdPartyChoiceL2B=>(params[:lender][:lenderThirdPartyChoiceL2B].blank? ? -1:params[:lender][:lenderThirdPartyChoiceL2B=].to_i),
          :borrower_contact_by_Facebook=> params[:lender][:borrower_contact_by_Facebook],
          :borrower_contact_by_LinkedIn=> params[:lender][:borrower_contact_by_LinkedIn],
          :borrower_contact_by_Other_Social_Media=> params[:lender][:borrower_contact_by_Other_Social_Media],
          :borrower_contact_by_Twitter=> params[:lender][:borrower_contact_by_Twitter],
          :borrower_contact_by_Instagram=> params[:lender][:borrower_contact_by_Instagram],
          :borrower_contact_by_Other_Social_Media_Access=> params[:lender][:borrower_contact_by_Other_Social_Media_Access],
          :category_id => params[:lender][:category_id].to_i,
          :item_description=> params[:lender][:item_description],
          :item_condition_id=> params[:lender][:item_condition_id].to_i,
          :other_item_category=> params[:lender][:other_item_category],
          :notify_borrowers=> (params[:lender][:notify_borrowers].blank? ? -1:params[:lender][:notify_borrowers].to_i) ,
          :item_model=> params[:lender][:item_model],
          :item_count=> params[:lender][:item_count].to_i,
          :item_image_caption=> params[:lender][:item_image_caption],
          :security_deposit=> (params[:lender][:security_deposit].blank? ? -1:params[:lender][:security_deposit].to_i) ,
          :security_deposit_amount=> params[:lender][:security_deposit_amount] ,
          :for_free=> (params[:lender][:for_free].blank? ? -1:params[:lender][:for_free].to_i) ,
          :small_fee=> (params[:lender][:small_fee].blank? ? -1:params[:lender][:small_fee].to_i) ,
          :small_fee_amount=> params[:lender][:small_fee_amount],
          :available_for_purchase=> (params[:lender][:available_for_purchase].blank? ? -1:params[:lender][:available_for_purchase].to_i) ,
          :available_for_purchase_amount=> params[:lender][:available_for_purchase_amount],
          :donate_anonymous => (params[:lender][:donate_anonymous].blank? ? -1:params[:lender][:donate_anonymous].to_i) ,
          :available_for_donation => (params[:lender][:available_for_donation].blank? ? -1:params[:lender][:available_for_donation].to_i) ,
          :trade=> (params[:lender][:trade].blank? ? -1: params[:lender][:trade].to_i),
          :trade_item=> params[:lender][:trade_item],
          :agreed_number_of_days=>(params[:lender][:agreed_number_of_days].blank? ? -1:params[:lender][:agreed_number_of_days].to_i),
          :agreed_number_of_hours=>(params[:lender][:agreed_number_of_hours].blank? ? -1:params[:lender][:agreed_number_of_hours].to_i),
          :indefinite_duration=>(params[:lender][:indefinite_duration].blank? ? -1:params[:lender][:indefinite_duration].to_i),
          :present_during_borrowing_period=>(params[:lender][:present_during_borrowing_period].blank? ? -1:params[:lender][:present_during_borrowing_period].to_i),
          :entire_period =>(params[:lender][:entire_period].blank? ? -1:params[:lender][:entire_period].to_i),
          :partial_period =>(params[:lender][:partial_period ].blank? ? -1:params[:lender][:partial_period ].to_i),
          :provide_proper_use_training =>(params[:lender][:provide_proper_use_training ].blank? ? -1:params[:lender][:provide_proper_use_training ].to_i),
          :specific_conditions=> params[:lender][:specific_conditions],
          :goodwill=> params[:lender][:goodwill].to_i,
          :age_18_or_more=>params[:lender][:age_18_or_more].to_i,
          :is_active => params[:lender][:is_active].to_i,
          :is_community => (session[:community_name].blank? ? 0 : 1),
          :date_created => Time.now,
          :approved => 0]
       
        @lender = Lender.new(@myupdatehash[0])
        if @lender.save(:validate => true) && @lender.errors.empty?
            
            @lender.addresses      <<  Address.new(params[:lender][:primary_address])   
            @lender.addresses      <<  Address.new(params[:lender][:alternative_address])
            @lender.item_images    <<  ItemImage.new(params[:lender][:item_image_new])   
        end      
        if @lender.errors.empty?
          session[:notice]  = "Echo Market successful in creating your new lender record."
          return true
        else
          session[:notice]  = "Echo Market was not successful in creating your new lender record. Please try again, and if problem persists contact us."
          return false
        end

      elsif (!params[:lender][:id].blank?)
        ## do update
        @ltmp = Lender.find(:first, :conditions => ["id = ?",params[:lender][:id] ])
        @useWhichContactAddress = (params[:lender][:useWhichContactAddress].blank? ? 0: params[:lender][:useWhichContactAddress].to_i)
               
        @myupdatehash = Hash.new
        @myupdatehash = [
           
          :contact_describe_id =>  params[:lender][:contact_describe_id].to_i,
          :other_describe_yourself => params[:lender][:other_describe_yourself],
          :organization_name => params[:lender][:organization_name],
          :displayLenderOrganizationName => (params[:lender][:displayLenderOrganizationName].blank? ? -1  : params[:lender][:displayLenderOrganizationName].to_i),
          :first_name=> params[:lender][:first_name],
          :mi=> params[:lender][:mi],
          :displayLenderName => (params[:lender][:displayLenderName].blank? ? -1 :params[:lender][:displayLenderName].to_i) ,
          :displayLenderAddress => (params[:lender][:displayLenderAddress].blank? ? -1 :params[:lender][:displayLenderAddress].to_i) ,
          :last_name=>params[:lender][:last_name],
          :useWhichContactAddress => @useWhichContactAddress,
          :home_phone => params[:lender][:home_phone],
          :public_display_home_phone=> (params[:lender][:public_display_home_phone].blank? ? -1:params[:lender][:public_display_home_phone].to_i) ,
          :cell_phone=> params[:lender][:cell_phone],
          :public_display_cell_phone=>  (params[:lender][:public_display_cell_phone].blank? ? -1: params[:lender][:public_display_cell_phone].to_i) ,
          :alternative_phone=>params[:lender][:alternative_phone],
          :public_display_alternative_phone=>(params[:lender][:public_display_alternative_phone].blank? ? -1: params[:lender][:public_alternative_cell_phone].to_i) ,
          :email_alternative=> params[:lender][:email_alternative],
          :borrower_contact_by_email=> (params[:lender][:borrower_contact_by_email].blank? ? -1:params[:lender][:borrower_contact_by_email].to_i) ,
          :borrower_contact_by_home_phone=> params[:lender][:borrower_contact_by_home_phone],
          :borrower_contact_by_cell_phone=> params[:lender][:borrower_contact_by_cell_phone],
          :borrower_contact_by_alternative_phone=> params[:lender][:borrower_contact_by_alternative_phone],
          :b_comes_to_which_address=> (params[:lender][:b_comes_to_which_address].blank? ? -1:params[:lender][:b_comes_to_which_address].to_i),
          :meetBorrowerAtAgreedL2B=> (params[:lender][:meetBorrowerAtAgreedL2B].blank? ? -1:params[:lender][:meetBorrowerAtAgreedL2B].to_i),
          :willDeliverToBorrowerPreferredL2B=> (params[:lender][:willDeliverToBorrowerPreferredL2B].blank? ? -1:params[:lender][:willDeliverToBorrowerPreferredL2B].to_i),
          :thirdPartyPresenceL2B=> (params[:lender][:thirdPartyPresenceL2B].blank? ? -1:params[:lender][:thirdPartyPresenceL2B].to_i),
          :b_returns_to_which_address=>(params[:lender][:b_returns_to_which_address].blank? ? -1:params[:lender][:b_returns_to_which_address].to_i),
          :meetBorrowerAtAgreedB2L=> (params[:lender][:meetBorrowerAtAgreedB2L].blank? ? -1:params[:lender][:meetBorrowerAtAgreedB2L].to_i),
          :willPickUpPreferredLocationB2L=>(params[:lender][:willPickUpPreferredLocationB2L].blank? ? -1:params[:lender][:willPickUpPreferredLocationB2L].to_i),
          :thirdPartyPresenceB2L=>(params[:lender][:agreedThirdPartyChoiceB2L=].blank? ? -1:params[:lender][:agreedThirdPartyChoiceB2L=].to_i),
          :agreedThirdPartyChoiceB2L=>(params[:lender][:agreedThirdPartyChoiceB2L].blank? ? -1:params[:lender][:agreedThirdPartyChoiceB2L=].to_i),
          :agreedThirdPartyChoiceL2B=>(params[:lender][:agreedThirdPartyChoiceL2B].blank? ? -1:params[:lender][:agreedThirdPartyChoiceL2B=].to_i),
          :lenderThirdPartyChoiceB2L=>(params[:lender][:lenderThirdPartyChoiceB2L].blank? ? -1:params[:lender][:lenderThirdPartyChoiceB2L=].to_i),
          :lenderThirdPartyChoiceL2B=>(params[:lender][:lenderThirdPartyChoiceL2B].blank? ? -1:params[:lender][:lenderThirdPartyChoiceL2B=].to_i),
          :borrower_contact_by_Facebook=> params[:lender][:borrower_contact_by_Facebook],
          :borrower_contact_by_LinkedIn=> params[:lender][:borrower_contact_by_LinkedIn],
          :borrower_contact_by_Other_Social_Media=> params[:lender][:borrower_contact_by_Other_Social_Media],
          :borrower_contact_by_Twitter=> params[:lender][:borrower_contact_by_Twitter],
          :borrower_contact_by_Instagram=> params[:lender][:borrower_contact_by_Instagram],
          :borrower_contact_by_Other_Social_Media_Access=> params[:lender][:borrower_contact_by_Other_Social_Media_Access],
          :category_id => params[:lender][:category_id].to_i,
          :item_description=> params[:lender][:item_description],
          :item_condition_id=> params[:lender][:item_condition_id].to_i,
          :other_item_category=> params[:lender][:other_item_category],
          :notify_borrowers=> (params[:lender][:notify_borrowers].blank? ? -1:params[:lender][:notify_borrowers].to_i) ,
          :item_model=> params[:lender][:item_model],
          :item_count=> params[:lender][:item_count].to_i,
          :item_image_caption=> params[:lender][:item_image_caption],
          :security_deposit=> (params[:lender][:security_deposit].blank? ? -1:params[:lender][:security_deposit].to_i) ,
          :security_deposit_amount=> params[:lender][:security_deposit_amount] ,
          :for_free=> (params[:lender][:for_free].blank? ? -1:params[:lender][:for_free].to_i) ,
          :small_fee=> (params[:lender][:small_fee].blank? ? -1:params[:lender][:small_fee].to_i) ,
          :small_fee_amount=> params[:lender][:small_fee_amount],
          :available_for_purchase=> (params[:lender][:available_for_purchase].blank? ? -1:params[:lender][:available_for_purchase].to_i) ,
          :available_for_purchase_amount=> params[:lender][:available_for_purchase_amount],
          :donate_anonymous => (params[:lender][:donate_anonymous].blank? ? -1:params[:lender][:donate_anonymous].to_i) ,
          :available_for_donation => (params[:lender][:available_for_donation].blank? ? -1:params[:lender][:available_for_donation].to_i) ,
          :trade=> (params[:lender][:trade].blank? ? -1: params[:lender][:trade].to_i),
          :trade_item=> params[:lender][:trade_item],
          :agreed_number_of_days=>(params[:lender][:agreed_number_of_days].blank? ? -1:params[:lender][:agreed_number_of_days].to_i),
          :agreed_number_of_hours=>(params[:lender][:agreed_number_of_hours].blank? ? -1:params[:lender][:agreed_number_of_hours].to_i),
          :indefinite_duration=>(params[:lender][:indefinite_duration].blank? ? -1:params[:lender][:indefinite_duration].to_i),
          :present_during_borrowing_period=>(params[:lender][:present_during_borrowing_period].blank? ? -1:params[:lender][:present_during_borrowing_period].to_i),
          :entire_period =>(params[:lender][:entire_period].blank? ? -1:params[:lender][:entire_period].to_i),
          :partial_period =>(params[:lender][:partial_period ].blank? ? -1:params[:lender][:partial_period ].to_i),
          :provide_proper_use_training =>(params[:lender][:provide_proper_use_training ].blank? ? -1:params[:lender][:provide_proper_use_training ].to_i),
          :specific_conditions=> params[:lender][:specific_conditions],
          :goodwill=> params[:lender][:goodwill].to_i,
          :age_18_or_more=>params[:lender][:age_18_or_more].to_i,
          :is_active => params[:lender][:is_active].to_i,
          :is_community => (session[:community_name].blank? ? 0 : 1),
          :date_created => Time.now,
          :approved => 0 ]


        if @ltmp.update_attributes(@myupdatehash[0])
          @ltmp.update_attributes(:addresses_attributes => params[:lender][:primary_address])          
          @ltmp.update_attributes(:addresses_attributes => params[:lender][:alternative_address])
          @ltmp.update_attributes(:item_images_attributes => params[:lender][:item_images])
          session[:notice]  = "Echo Market was successful in updating your lender record."
          return true
        else
          session[:notice]  = "Echo Market was not successful in updating your lender record. "
          return false
        end
      end
     
     
    end
  end
  
  
  def get_random_password
    length = 8
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    @password = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @password
  end

 def create
    return_value =  false
    unless params[:lender].blank?
        @lender = Lender.new(
          :contact_describe_id => 1,
          :first_name => 'NA',
          :last_name => 'NA',
          :displayLenderName => 0,
          :displayLenderAddress  => 0,
          :useWhichContactAddress => 0,
          :email_alternative=> params[:lender][:email_alternative],
          :lender_contact_by_email=> 2,
          :category_id => params[:lender][:category_id],
          :item_description=> params[:lender][:item_description],
          :item_condition_id=> params[:lender][:item_condition_id],
          :other_item_category=> params[:lender][:other_item_category],
          :item_model=> params[:lender][:item_model],
          :item_count=> params[:lender][:item_count].to_i,
          :goodwill=> params[:lender][:goodwill].to_i,
          :age_18_or_more=>params[:lender][:age_18_or_more].to_i,
          :is_active => params[:lender][:is_active].to_i,
          :is_community => params[:lender][:is_community].to_i,
          :date_created => Time.now,
          :approved => 1,
          :remote_ip => params[:lender][:remote_ip],
          :comment => params[:lender][:comment]          
 )
                 
         if @lender.save(:validate => true) && @lender.errors.empty? 
          @un = 'rapid_' + @lender.item_description
          myupdatehash = Hash.new
          fake_password =  get_random_password
          myupdatehash = [:username => @un, :email => @lender.email_alternative,  
                           :remote_ip => @lender.remote_ip, :user_alias => @un, :approved => 1, :is_rapid => 1, 
                           :user_type => 'lender', :password =>fake_password, :password_confirmation => fake_password  ]        
          @user_new = User.new(myupdatehash[0])
        
              if @user_new.save(:validate => true)   &&  @user_new.errors.empty?
                
                  @lender.addresses << Address.new(params["addresses"])
                  @myupdatehash = [:lender_id => @lender.id, :date_created => Time.now, :image_file_name => 'NA']
                  @lender.item_images << ItemImage.new(@myupdatehash[0])
                  
                  if @lender.errors.empty?
                    Notifier.notify_rapid(@user_new).deliver
                    session[:notice] = "Your lender's record has been saved, and email has been sent to your email address, #{@user_new.email}."
                    return_value =  true
                  end
         
              else
                  session[:notice] = ''
                  @user_new.errors.full_messages.each do |msg|
                  session[:notice] = session[:notice] +  msg + " " 
                  end
                  return_value = false
              end  
         
          else
            return_value = false
          end      
     
     end   # close unless
     return_value    
 end   # close def 


end