class CommunityController < ApplicationController
  
  def new
    if params[:community]
        if create_new_community
          redirect_to  home_items_listing_url
       end
   else  
     @community = Community.new
    end 
     
  end

 def edit
    if params[:id]
      update
    else
      @community = Community.find(session[:community_id])
    end   
  end 
  
   def list
      session[:background] = true
      @community = CommunityMember.find(:all, :conditions => ["community_id = ?", session[:community_id]])
      
   end


  def advise
     session[:background] = true
     if params[:community]
       @community = ''
       if create
          @community = Community.find(session[:community_id])
       end  
     else

       @community = Community.find(session[:community_id])
       unless @community.community_members.noncreator_community_members
         3.times { @community.community_members.noncreator_community_members.build }
       end
     end    
     
  end
  

  
    def create_new_community
    session[:notice] = ''
    @community = Community.new(params[:community])
    
      
      if @community.save(:validate =>true) && @community.errors.empty?
        myhashformembers = Hash.new
        myhashformembers = [:first_name => @community.first_name, 
                           :mi => @community.mi,
                           :last_name => @community.last_name, 
                           :remote_ip => @community.remote_ip, 
                           :date_created => Time.now, 
                           :is_active => 1, 
                           :is_creator => 1,
                           :user_type => 'both']
                           
        @community.community_members << CommunityMember.new(myhashformembers[0])
        
          if @community.save(:validate => false)
            session[:notice] = "Your Echo Market Community record, #{params[:community][:community_name]}, has been successfully created!  
            Please check your email, #{params[:community][:email]}, to activate your account."
            return true    
          else
            session[:notice]= "Error in creating Community record"
            return false
            
          end    
              
      end  #ends if saved 
    
  end  # ends def
  
    def logout

    @current_user = nil
    reset_session
    session[:notice] = "Thank you for exploring www.echomarket.org.  Please return soon."
    redirect_to home_items_listing_path

  end

 def create
    session[:notice] = ''
    respond_to do |format|
      
    if params[:commit] == "Update Creator"
       myupdatehash = Hash.new
       myupdatehash = [:first_name => params[:community][:first_name], :mi => params[:community][:mi], :last_name => params[:community][:last_name]]
       @community = Community.find(:first, :conditions => ["id = ?", params[:id].to_s])
      
          unless @community.blank?
              @community.first_name = params[:community][:first_name]
              @community.mi = params[:community][:mi]
              @community.last_name = params[:community][:last_name]
              @community.save(:validate => false)
              @cm = CommunityMember.find(:first, :conditions => ["is_creator = 1 AND community_id = ?", params[:id].to_s])
                puts @cm
                unless @cm.blank?
                    begin
                      @cm.update_attributes(myupdatehash[0])
                    rescue
                      puts "Couldn't update community"
                      puts e.msg
                    end  
                      
                        
                else
                  session[:notice] = "Couldn't update Community creator member name."
                  return false
                end       
          else
             session[:notice] = "Couldn't update Community creator name."
             return false
          end       
                
                
       if @community.errors.empty? &&  @cm.errors.empty?
         session[:notice] = "Successful update of Echo Market Community creator record."
         return true
       else
         session[:notice] = "Echo Market Community was not successful in updating your Community Creator record."
         return false  
       end
       elsif params[:commit] == "Add New Member"
         @community = Community.find(params[:id])
         @community.community_members << CommunityMember.new(params[:noncreator_cm])
         return true
     end  # end if params   
    
     end  # end do format
  end  # ends def
    
  def activate
    
    reset_session
    @cm = params[:activation_code].blank? ? false : Community.find_by_activation_code(params[:activation_code])
    unless @cm.blank?
        unless @cm.activation_code.blank?
             if @cm.activate
                  
                  @current_user = CommunityMember.find(:first, :readonly, :conditions => ["community_id = ? AND is_creator = 1", @cm.id])
                                unless @current_user.blank? 
                                  session[:user_id] = @current_user.id 
                                  session[:community_id] = @current_user.community_id
                                  session[:user_type] = session[:register_type] = @cm.user_type
                                  session[:community_name] = @cm.community_name
                                  session[:user_alias] = (@current_user.first_name.blank? ? @current_user.alias : @current_user.first_name + " " + (@current_user.mi.blank? ? "": @current_user.mi) + " " + @current_user.last_name) 
                                  session[:notice] = @cm.community_name + ", your registration activation is complete, and you are now logged in."
                                  session[:advise] = true
                                  redirect_to :controller=> "community", :action=>"advise", :id => @cm.id
                               else
                                  session[:notice] = "Echo Market failed to locate Community creator record."
                                  session[:advise] = false
                                  redirect_to home_items_listing_url
                               
                               end   
              else  ## activate failed to save
                 session[:notice] = "Echo Market failed to activate your Community record."
                 session[:advise] = false
                 redirect_to home_items_listing_url
              end  ## if active saved
                  
                    
         else   ## activate code not found
             session[:advise] = false
             session[:notice] = "Seems that you may have not properly copied the Activation url provided in your email.  Please try again."
             redirect_to :controller=> "home", :action=>"items_listing"
         end  
    else
       session[:advise] = false
       session[:notice] = "Your Community record has already been activated.  Please just login."
       redirect_to :controller=> "home", :action=>"items_listing"
   
      
    end  ## unless community with activation code not found
  end  ## ends def
  
  
  
   def forgot_community_name
    session[:background] = true
    if request.post?
      forgot('community_name')
    else
      @community = Community.new
    end
  end

  def forgot_community_password
    session[:background] = true
    if request.post?
      forgot('password')
    else
      @community = Community.new
    end
  end

  def forgot(which)
   
    session[:notice] = ''
    if request.post?
      @community = Community.find(:first, :conditions => ['email = ?', params[:community][:email]])

      unless @community.blank?
        @community.create_reset_code(which)
        if which == 'community_name'
          # respond_to do |format|
          Notifier.get_community_notification(@community).deliver if @community.recently_reset? && @community.recently_community_name_get?
          #format.html
          session[:notice] = "Path to retrieve Community name sent to #{@community.email}"
        #end
        else
          Notifier.reset_community_password_notification(@community).deliver if @community.recently_reset? && @community.recently_password_reset?
          session[:notice] = "Path to reset password code sent to #{@community.email}"
        end
        redirect_to home_items_listing_url

      else
        session[:notice] = "Email: '#{params[:community][:email]}' does not exist in the Echo Market database."
        redirect_to home_items_listing_url

      end

    end  #end def
    
   respond_to do |format|
   format.html
  end
  end
      


  def get_community_name
    session[:notice] = ''
    @c = Community.find_by_reset_code(params[:id]) unless params[:id].blank?
    if @c
      @c.delete_reset_code
      session[:notice] = "Your Community Name is #{@c.community_name}. Please login."
      redirect_to home_items_listing_url
    else
      session[:notice] = "Your Community Name was previously reported to you. Please try to login again."
      redirect_to home_items_listing_url
    end

  end

  def reset_community_password

    @community= Community.find(:first, :conditions => ["reset_code =?", params[:reset_code]])
    unless @community.blank?
      @myupdatehash = Hash.new
      @myupdatehash = [:password => params[:community][:password], :password_confirmation => params[:community][:password_confirmation]]
      @community.update_attributes(@myupdatehash[0])
      @community.delete_reset_code
      session[:notice] = "Password reset successfully for #{@community.email}. Please login"
      redirect_to home_items_listing_url
    else
      session[:notice] = "There was an error in updating your password, please contact the Echo Market. Perhaps you are trying to update your password from an old email notification."
      redirect_to home_items_listing_url
    end

  end

  def get_reset_community_password
    session[:background] = true
    @community = Community.find(:first, :conditions => ["reset_code =?", params[:id]])
  end
    
end
