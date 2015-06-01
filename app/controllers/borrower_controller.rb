class BorrowerController < ApplicationController


def rapid_borrower_seeking
    
    session[:background] = true 
    if params[:borrower]
      if create
         redirect_to home_items_listing_url
      end
    else
      @borrower = Borrower.new
      
     respond_to do |f|
      f.html
    end
    end
    

end

 
 def b_list
      session[:notice] = ''
      session[:background] = true
      if session[:community_name].blank? 
         @borrower = Borrower
                  .joins(:category, :item_condition, :item_images)
                  .select(["borrowers.*", "borrowers.id AS b_id", "categories.category_type", "item_conditions.condition", "item_images.*"])
                  .where(" borrowers.is_active=1 AND (borrowers.is_community = 0  OR borrowers.is_community = 3 )") 
                  .order("categories.category_type ASC, borrowers.date_created ASC ")
      
      else 
          
         where_clause = "WHERE (borrowers.is_active= 1 AND borrowers.is_community = 1  AND borrowers.user_id  =  #{session[:user_id]}" 
         @borrower = Borrower
                  .joins(:category, :item_condition, :item_images)
                  .select(["borrowers.*", "borrowers.id AS b_id", "categories.category_type", "item_conditions.condition", "item_images.*"])
                  .where(where_clause) 
                  .order("categories.category_type ASC, lenders.date_created ASC ")
                  
               
      end 
      
     
    
     if @borrower.blank?
          
          if session[:user_id].blank?
            session[:notice] = "Sorry, no borrowers records have been created."
            redirect_to  home_items_listing_url
          else
            session[:notice] = "Sorry, no borrowers records have been created. Perhaps you would like to create one now."
            redirect_to  borrower_seeking_url
          end    
    
      end

     @borrower  
        
 end

 def borrower_item_detail
   where_clause = ""
    session[:background] = true
    unless params[:id].blank?
    
              if session[:community_name].blank?
                 where_clause = " borrowers.id =  #{params[:id]}"
                 
              else
                 where_clause = " borrowers.id = #{params[:id]} AND borrower.user_id = #{session[:user_id]}" 
                 
              end 
                                      
                   @borrower = Borrower
                  .joins(:category, :item_condition, :item_images, :contact_describe)
                  .select(["contact_describes.borrower_or_lender_text", "borrowers.*", "borrowers.id AS b_id",   "categories.category_type", "item_conditions.condition", 
                    "item_images.item_image_caption", "item_images.image_file_name"])
                  .where(where_clause) 
                  .order("categories.category_type ASC, borrowers.date_created ASC ")
                  
     
    end
    if @borrower.blank?
          session[:notice]  = "The borrower item you were seeking does not exist in the Echo Market database."  
          redirect_to home_items_listing_url
     end 
  
     
       @borrower
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
        
         @borrower = Borrower
                  .joins(:category, :item_condition)
                  .select(["borrowers.*", "categories.category_type", "item_conditions.condition"])
                  .where(" borrowers.is_active = 1 AND borrowers.user_id = ?", params[:id]) 
                  .order("categories.category_type ASC, borrowers.date_created ASC ")
   
        if @borrower.blank?
           redirect_to  :controller => "borrower", :action => @which_view
        else
          @borrower 
        end
   end     
         
  end

  def delete_borrower_record
    session[:background] = true
    if params['commit'] == "delete"
      @l = Borrower.update(params[:id], :is_active => 0,  :date_deleted => Time.now)
      @l.save
      @ld  = Borrower.find(:all, :readonly => true, :conditions => ["user_id = ? and is_active = 1", session[:user_id]])
      unless  @ld.blank?
        redirect_to :action => "borrower_history", :id=> session[:user_id]  
      else
        session[:notice] = "Seems that you have deleted all your records.  Hope it is because you were able to borrow an item."
        redirect_to :controller => "home", :action => "items_listing"
      end
    end
  end

  def borrower_seeking
    
    session[:no_border] = true
    if params[:borrower]
      if update_borrower_seeking
        redirect_to :action => 'borrower_history', :id=> session[:user_id]
      else
         @borrower
      end
      
    else
      if params[:id].blank?
       session[:edit_record] = false 
       @borrower = Borrower.new
      else
        @borrower = Borrower.find(params[:id])
      end
    end
    
  end
  
    def community_borrower_seeking
    
 
    session[:no_border] = true
    if params[:borrower]
      if update_borrower_seeking
        redirect_to :action => 'borrower_history', :id=> session[:user_id]
      else
         @borrower
      end
      
    else
      if params[:id].blank?
       session[:edit_record] = false 
       @borrower = Borrower.new
      else
        @borrower = Borrower.find(params[:id])
      end
    end
    
  end
  
   
 protected  
   
  def update_borrower_seeking
    session[:notice] = ''
    unless params[:borrower].blank?
      if (params[:borrower][:id].blank?)  ## then it is a new record
          
        @useWhichContactAddress = (params[:borrower][:useWhichContactAddress].blank? ? 0: params[:borrower][:useWhichContactAddress].to_i)
        @myupdatehash = Hash.new
        @myupdatehash = [
          :user_id => session[:user_id], 
          :contact_describe_id =>  params[:borrower][:contact_describe_id].to_i,
          :other_describe_yourself => params[:borrower][:other_describe_yourself],
          :organization_name => params[:borrower][:organization_name],
          :displayBorrowerOrganizationName => (params[:borrower][:displayBorrowerOrganizationName].blank? ? -1  : params[:borrower][:displayBorrowerOrganizationName].to_i),
          :first_name=> params[:borrower][:first_name],
          :mi=> params[:borrower][:mi],
          :displayBorrowerName => (params[:borrower][:displayBorrowerName].blank? ? -1 :params[:borrower][:displayBorrowerName].to_i) ,
          :displayBorrowerAddress => (params[:borrower][:displayBorrowerAddress].blank? ? -1 :params[:borrower][:displayBorrowerAddress].to_i) ,
          :last_name=> params[:borrower][:last_name],
          :useWhichContactAddress => @useWhichContactAddress,
          :home_phone => params[:borrower][:home_phone],
          :public_display_home_phone=> (params[:borrower][:public_display_home_phone].blank? ? -1:params[:borrower][:public_display_home_phone].to_i) ,
          :cell_phone=> params[:borrower][:cell_phone],
          :public_display_cell_phone=>  (params[:borrower][:public_display_cell_phone].blank? ? -1: params[:borrower][:public_display_cell_phone].to_i) ,
          :alternative_phone=>params[:borrower][:alternative_phone],
          :public_display_alternative_phone=>(params[:borrower][:public_display_alternative_phone].blank? ? -1: params[:borrower][:public_alternative_cell_phone].to_i) ,
          :email_alternative=> params[:borrower][:email_alternative],
          :borrower_contact_by_email=> (params[:borrower][:borrower_contact_by_email].blank? ? -1:params[:borrower][:borrower_contact_by_email].to_i) ,
          :borrower_contact_by_home_phone=> params[:borrower][:borrower_contact_by_home_phone],
          :borrower_contact_by_cell_phone=> params[:borrower][:borrower_contact_by_cell_phone],
          :borrower_contact_by_alternative_phone=> params[:borrower][:borrower_contact_by_alternative_phone],
          :borrower_contact_by_Facebook=> params[:borrower][:borrower_contact_by_Facebook],
          :borrower_contact_by_LinkedIn=> params[:borrower][:borrower_contact_by_LinkedIn],
          :borrower_contact_by_Other_Social_Media=> params[:borrower][:borrower_contact_by_Other_Social_Media],
          :borrower_contact_by_Twitter=> params[:borrower][:borrower_contact_by_Twitter],
          :borrower_contact_by_Instagram=> params[:borrower][:borrower_contact_by_Instagram],
          :borrower_contact_by_Other_Social_Media_Access=> params[:borrower][:borrower_contact_by_Other_Social_Media_Access],
          :notify_lenders=> (params[:borrower][:notify_lenders].blank? ? -1:params[:borrower][:notify_lenders].to_i) ,
          :category_id => params[:borrower][:category_id].to_i,
          :item_description=> params[:borrower][:item_description],
          :item_condition_id=> params[:borrower][:item_condition_id].to_i,
          :other_item_category=> params[:borrower][:other_item_category],
          :item_model=> params[:borrower][:item_model],
          :item_count=> params[:borrower][:item_count].to_i,
           :goodwill=> params[:borrower][:goodwill].to_i,
          :age_18_or_more=>params[:borrower][:age_18_or_more].to_i,
          :is_active => params[:borrower][:is_active].to_i,
          :is_community => (session[:community_name].blank? ? 0 : 1),
          :date_updated => Time.now,
          :approved => 0]
       
        @borrower = Borrower.new(@myupdatehash[0])
        if @borrower.save(:validate => true) && @borrower.errors.empty?
            
            @borrower.addresses      <<  Address.new(params[:borrower][:primary_address])   
            @borrower.addresses      <<  Address.new(params[:borrower][:alternative_address])
            @borrower.item_images    <<  ItemImage.new(params[:borrower][:item_image_new])   
        end      
        if @borrower.errors.empty?
          session[:notice]  = "Echo Market successful in creating your new borrower record."
          return true
        else
          session[:notice]  = "Echo Market was not successful in creating your new borrower record. Please try again, and if problem persists contact us."
          return false
        end

      elsif (!params[:borrower][:id].blank?)
        ## do update
        @ltmp = Borrower.find(:first, :conditions => ["id = ?",params[:borrower][:id] ])
        @useWhichContactAddress = (params[:borrower][:useWhichContactAddress].blank? ? 0: params[:borrower][:useWhichContactAddress].to_i)
               
        @myupdatehash = Hash.new
        @myupdatehash = [:contact_describe_id =>  params[:borrower][:contact_describe_id].to_i,
          :other_describe_yourself => params[:borrower][:other_describe_yourself],
          :organization_name => params[:borrower][:organization_name],
          :displayBorrowerOrganizationName => (params[:borrower][:displayBorrowerOrganizationName].blank? ? -1  : params[:borrower][:displayBorrowerOrganizationName].to_i),
          :first_name=> params[:borrower][:first_name],
          :mi=> params[:borrower][:mi],
          :displayBorrowerName => (params[:borrower][:displayBorrowerName].blank? ? -1 :params[:borrower][:displayBorrowerName].to_i) ,
          :displayBorrowerAddress => (params[:borrower][:displayBorrowerAddress].blank? ? -1 :params[:borrower][:displayBorrowerAddress].to_i) ,
          :last_name=> params[:borrower][:last_name],
          :useWhichContactAddress => @useWhichContactAddress,
          :home_phone => params[:borrower][:home_phone],
          :public_display_home_phone=> (params[:borrower][:public_display_home_phone].blank? ? -1:params[:borrower][:public_display_home_phone].to_i) ,
          :cell_phone=> params[:borrower][:cell_phone],
          :public_display_cell_phone=>  (params[:borrower][:public_display_cell_phone].blank? ? -1: params[:borrower][:public_display_cell_phone].to_i) ,
          :alternative_phone=>params[:borrower][:alternative_phone],
          :public_display_alternative_phone=>(params[:borrower][:public_display_alternative_phone].blank? ? -1: params[:borrower][:public_alternative_cell_phone].to_i) ,
          :email_alternative=> params[:borrower][:email_alternative],
          :borrower_contact_by_email=> (params[:borrower][:borrower_contact_by_email].blank? ? -1:params[:borrower][:borrower_contact_by_email].to_i) ,
          :borrower_contact_by_home_phone=> params[:borrower][:borrower_contact_by_home_phone],
          :borrower_contact_by_cell_phone=> params[:borrower][:borrower_contact_by_cell_phone],
          :borrower_contact_by_alternative_phone=> params[:borrower][:borrower_contact_by_alternative_phone],
          :borrower_contact_by_Facebook=> params[:borrower][:borrower_contact_by_Facebook],
          :borrower_contact_by_LinkedIn=> params[:borrower][:borrower_contact_by_LinkedIn],
          :borrower_contact_by_Other_Social_Media=> params[:borrower][:borrower_contact_by_Other_Social_Media],
          :borrower_contact_by_Twitter=> params[:borrower][:borrower_contact_by_Twitter],
          :borrower_contact_by_Instagram=> params[:borrower][:borrower_contact_by_Instagram],
          :borrower_contact_by_Other_Social_Media_Access=> params[:borrower][:borrower_contact_by_Other_Social_Media_Access],
          :notify_lenders=> (params[:borrower][:notify_lenders].blank? ? -1:params[:borrower][:notify_lenders].to_i) ,
          :category_id => params[:borrower][:category_id].to_i,
          :item_description=> params[:borrower][:item_description],
          :item_condition_id=> params[:borrower][:item_condition_id].to_i,
          :other_item_category=> params[:borrower][:other_item_category],
          :item_model=> params[:borrower][:item_model],
          :item_count=> params[:borrower][:item_count].to_i,
          :goodwill=> params[:borrower][:goodwill].to_i,
          :age_18_or_more=>params[:borrower][:age_18_or_more].to_i,
          :is_active => params[:borrower][:is_active].to_i,
          :is_community => (session[:community_name].blank? ? 0 : 1),
          :date_updated => Time.now,
          :approved => 0]


        if @ltmp.update_attributes(@myupdatehash[0])
          @ltmp.update_attributes(:addresses_attributes => params[:borrower][:primary_address])          
          @ltmp.update_attributes(:addresses_attributes => params[:borrower][:alternative_address])
          @ltmp.update_attributes(:item_images_attributes => params[:borrower][:item_images])
          session[:notice]  = "Echo Market was successful in updating your borrower record."
          return true
        else
          session[:notice]  = "Echo Market was not successful in updating your borrower record. "
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
    unless params[:borrower].blank?
        @borrower = Borrower.new(
          :contact_describe_id => 1,
          :first_name => 'NA',
          :last_name => 'NA',
          :displayBorrowerName => 0,
          :displayBorrowerAddress  => 0,
          :useWhichContactAddress => 0,
          :email_alternative=> params[:borrower][:email_alternative],
          :borrower_contact_by_email=> 2,
          :category_id => params[:borrower][:category_id],
          :item_description=> params[:borrower][:item_description],
          :item_condition_id=> params[:borrower][:item_condition_id],
          :other_item_category=> params[:borrower][:other_item_category],
          :item_model=> params[:borrower][:item_model],
          :item_count=> params[:borrower][:item_count].to_i,
          :goodwill=> params[:borrower][:goodwill].to_i,
          :age_18_or_more=>params[:borrower][:age_18_or_more].to_i,
          :is_active => params[:borrower][:is_active].to_i,
          :is_community => params[:borrower][:is_community].to_i,
          :date_created => Time.now,
          :approved => 1,
          :remote_ip => params[:borrower][:remote_ip],
          :comment => params[:borrower][:comment]          
 )
                 
         if @borrower.save(:validate => true) && @borrower.errors.empty? 
          @un = 'rapid_' + @borrower.item_description
          myupdatehash = Hash.new
          fake_password =  get_random_password
          myupdatehash = [:username => @un, :email => @borrower.email_alternative,  
                           :remote_ip => @borrower.remote_ip, :user_alias => @un, :approved => 1, :is_rapid => 1, 
                           :user_type => 'borrower', :password =>fake_password, :password_confirmation => fake_password  ]        
          @user_new = User.new(myupdatehash[0])
        
              if @user_new.save(:validate => true)   &&  @user_new.errors.empty?
                
                  @borrower.addresses << Address.new(params["addresses"])
                  @myupdatehash = [:borrower_id => @borrower.id, :date_created => Time.now, :image_file_name => 'NA']
                  @borrower.item_images << ItemImage.new(@myupdatehash[0])
                  
                  if @borrower.errors.empty?
                    Notifier.notify_rapid(@user_new).deliver
                    session[:notice] = "Your borrower's record has been saved, and email has been sent to your email address, #{@user_new.email}."
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