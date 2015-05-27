class BorrowerController < ApplicationController


def rapid_borrower_seeking
    session[:notice] = ''
    session[:background] = true 
    if params[:borrower]
      create
    else
      @borrower = Borrower.new
    end
end

 def create
   session[:notice] = ''
    unless params[:borrower].blank?
        
        @borrower = Borrower.new(
          :user_id => 'NA',
          :describe_yourself => -1,
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
         if @borrower.save(:validate => false)
          @borrower.update_attributes(:addresses_attributes => params['addresses'])  
          @un = 'rapid_' + @borrower.item_description
         @user = User.new(:username => @un, :email => @borrower.email_alternative, :created_at => Time.now, 
                    :remote_ip => @borrower.remote_ip, :user_alias => @un, :approved => 1, :is_rapid => 1, :user_type => 'borrower', :activated_at => Time.now, :activation_code => '', :password => get_random_password)        
         @user.save(:validate => false)
         @myupdatehash = [:user_id => @user.user_id]
         if @borrower.update_attributes(@myupdatehash[0])
          Notifier.notify_rapid(@user).deliver
          session[:notice] = "Your borrower's record has been saved."
          redirect_to  :controller => "search", :action => 'item_search' 
         end
         end
     end       
 end


###  Could not get multipe table associations to WORK! 
 def b_list
      session[:notice] = ''
      session[:background] = true
      if session[:community_name].blank? 
        my_sql_string = "select borrowers.*, item_conditions.condition, categories.category_type, item_images.*  
              FROM borrowers
              INNER JOIN categories ON categories.id = borrowers.category_id
              INNER JOIN item_conditions ON item_conditions.id = borrowers.item_condition_id
              INNER JOIN item_images ON item_images.borrower_id = borrowers.id
              WHERE (borrowers.is_active=1 and (borrowers.is_community = 0  OR borrowers.is_community = 3))
              ORDER BY borrowers.category_type ASC, borrowers.date_created ASC"
              
        @borrower = Borrower.find_by_sql my_sql_string       
                
      else 
          
          my_sql_string = "select borrowers.*, item_conditions.condition, categories.category_type, item_images.*  
              FROM borrowers
              INNER JOIN categories ON categories.id = borrowers.category_id
              INNER JOIN item_conditions ON item_conditions.id = borrowers.item_condition_id
              INNER JOIN item_images ON item_images.borrower_id = borrowers.id
              WHERE (borrowers.is_active=1 AND  borrowers.is_community = 1 AND borrowers.user_id =  "
          my_sql_string =  my_sql_string + session[:user_id]
          my_sql_string =  my_sql_string + " ) ORDER BY borrowers.category_type ASC, borrowers.date_created ASC" 
          @borrower = Borrower.find_by_sql my_sql_string
      
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
        
 end

 def borrower_item_detail
    session[:background] = true
    unless params[:id].blank?
      
            my_sql_string = "select borrowers.*, item_conditions.condition, categories.category_type  
              FROM borrowers
              INNER JOIN categories ON categories.id = borrowers.category_id
              INNER JOIN item_conditions ON item_conditions.id = borrowers.item_condition_id
              INNER JOIN addresses ON addresses.borrower_id = borrowers.id
              WHERE borrowers.id = "
           my_sql_string = my_sql_string + params[:id]  
           my_sql_string = my_sql_string + " ORDER BY borrowers.category_type ASC, borrowers.date_created ASC"
      
           @borrower = Borrower.find_by_sql my_sql_string
    end
      if @borrower.blank? || params[:id].blank?
          session[:notice]  = "The borrower item you were seeking does not exist in the Echo Market database."  
          redirect_to home_items_listing_url
      end 
      
  end
 
   def community_borrower_item_detail
     session[:background] = true
     unless params[:id].blank?
        session[:reuse] = (params['commit'] == 'reuse' ? true : false)
        session[:edit_record] = (params['commit'] == 'edit' ? true : false)
        my_sql_string = "select borrowers.*, item_conditions.condition, categories.category_type  
              FROM borrowers
              INNER JOIN categories ON categories.id = borrowers.category_id
              INNER JOIN item_conditions ON item_conditions.id = borrowers.item_condition_id
              INNER JOIN addresses ON addresses.borrower_id = borrowers.id
              WHERE borrowers.id = "
           my_sql_string = my_sql_string + params[:id]  
           my_sql_string = my_sql_string + " AND borrowers.user_id = " + params[:user_id]
           my_sql_string = my_sql_string + " ORDER BY borrowers.category_type ASC, borrowers.date_created ASC"
      
           @borrower = Borrower.find_by_sql my_sql_string
               
        
     end
     
     if @borrower.blank? || params[:id].blank?
          session[:notice]  = "The borrower item you were seeking does not exist in the Echo Market database."  
          redirect_to home_items_listing_url
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
        
    my_sql_string = "select borrowers.*, item_conditions.condition, categories.category_type  
              FROM borrowers
              INNER JOIN categories ON categories.id = borrowers.category_id
              INNER JOIN item_conditions ON item_conditions.id = borrowers.item_condition_id
              WHERE (borrowers.is_active=1 and borrowers.user_id = "
              my_sql_string  = my_sql_string + params[:id]
              my_sql_string  = my_sql_string + " ) ORDER BY borrowers.category_id ASC, borrowers.date_created ASC "    
          
        @borrower = Borrower.find_by_sql my_sql_string
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
      unless update_borrower_seeking
        @borrower
      end
      
    else
      if params[:id].blank?
       @borrower = Borrower.new
      else
        @borrower = Borrower.find(params[:id])
      end
    end
    
  end
  
  def community_borrower_seeking
        session[:no_border] = true

     if params[:id].blank?
        @borrower = Borrower.new
    else
        @borrower = Borrower.find(params[:id])
    end
  end
   
  def update_borrower_seeking
    session[:notice] = ''
    unless params[:borrower].blank?
      if (params[:borrower][:id].blank?)  ## then it is a new record
          
        @useWhichContactAddress = (params[:borrower][:useWhichContactAddress].blank? ? 0: params[:borrower][:useWhichContactAddress].to_i)
        @myupdatehash = Hash.new
        @myupdatehash = [
          :user_id => session[User_id], 
          :describe_yourself =>  params[:borrower][:describe_yourself].to_i,
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
          :item_image => params[:borrower][:item_image],
          :goodwill=> params[:borrower][:goodwill].to_i,
          :age_18_or_more=>params[:borrower][:age_18_or_more].to_i,
          :is_active => params[:borrower][:is_active].to_i,
          :is_community => (session[:community_name].blank? ? 0 : 1),
          :date_updated => Time.now,
          :approved => 0]
       
        @borrower = Borrower.new(@myupdatehash[0])
               
        if @borrower.save(:validate => true) && @borrower.errors.empty?
          @borrower.update_attributes(:addresses_attributes => params[:primary_address])          
          @borrower.update_attributes(:addresses_attributes => params[:alternative_address])
           redirect_to :action => 'borrower_history', :id=> session[:user_id]
        else
          return false
        end

      elsif (!params[:borrower][:id].blank?)
        ## do update
        @ltmp = Borrower.find(:first, :conditions => ["id = ?",params[:borrower][:id] ])
        @useWhichContactAddress = (params[:borrower][:useWhichContactAddress].blank? ? 0: params[:borrower][:useWhichContactAddress].to_i)
               
        @myupdatehash = Hash.new
        @myupdatehash = [:describe_yourself =>  params[:borrower][:describe_yourself].to_i,
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
          :item_image => params[:borrower][:item_image],
          :goodwill=> params[:borrower][:goodwill].to_i,
          :age_18_or_more=>params[:borrower][:age_18_or_more].to_i,
          :is_active => params[:borrower][:is_active].to_i,
          :is_community => (session[:community_name].blank? ? 0 : 1),
          :date_updated => Time.now,
          :approved => 0]


        if @ltmp.update_attributes(@myupdatehash[0])
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
  
  
  def get_random_password
    length = 8
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    @password = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @password
  end

end