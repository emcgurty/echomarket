class CommunityController < ApplicationController
  
  def new
    if params[:community]
      if create_new_community
        session[:notice] = "Your Echo Market Community record, #{params[:community][:community_name]}, has been successfully created!  Please check your email, #{params[:community][:email]}, to activate your account."
      else
        @community
      end
    else  
     @community = Community.new
    end 
     respond_to do |format|
     format.html # new.html.erb

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
      @community_member = @community.community_member.all
  end
  
  def advise
     session[:background] = true
     if params[:community]
       if create
       end  
     else
         @community = Community.find(:all, :conditions => ["community_id = ?", session[:community_id]])
     end    
     
  end
   
 
  protected
  
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
       @community = Community.find(params[:community][:community_id])
       @community.update_attributes(params[:community])
       if @community.errors.empty?
         session[:notice] = "Successful update of Echo Market Community creator record."
         return true
       else
         session[:notice] = "Echo Market Community was not successful in updating your Community Creator record."
         return false  
       end
    elsif params[:commit] == "Add Member"
       @community.community_members   <<  CommunityMembers.new(params[:community][:community_members]) 
        if @community.errors.empty?
         session[:notice] = "Successful addition of Echo Market Community member."
         return true
       else
         session[:notice] = "Echo Market Community was not successful in adding Community member record."
         return false  
       end
    end     
    
     end
  end  # ends def
 
  def update
    session[:notice] = ''
    if params[:id]
      myupdatehash = Hash.new
      if params[:community]
        @c = params[:community]
        myupdatehash = [:remote_ip=> @c[:remote_ip],
                        :approved=> 1,
                        :is_active=>1,
                        :community_name=> @c[:community_name], 
                        :email=> @c[:email],
                        :password=> @c[:password], 
                        :password_confirmation=> @c[:password_confirmation],
                        :first_name=> @c[:first_name], 
                        :mi=> @c[:mi], 
                        :last_name=> @c[:last_name], 
                        :address_line_1=> @c[:address_line_1], 
                        :address_line_2=>@c[:address_line_2], 
                        :postal_code=>@c[:postal_code], 
                        :city=>@c[:city],  
                        :province=>@c[:province], 
                        :country_id=>@c[:country_id].to_s, 
                        :us_state_id=>@c[:us_state_id].to_s,  
                        :region=>@c[:region], 
                        :home_phone=>@c[:home_phone], 
                        :cell_phone => @c[:cell_phone] ]

     
     @community = Community.find(params[:id])
     if @community.update_attributes(myupdatehash[0]) && @community.errors.empty? 
        @cm = CommunityMember.find(:first, :conditions => ["community_id = ? and is_creator = 1",params[:id] ])
        @cm.first_name = params[:community][:first_name]
        @cm.mi = params[:community][:mi]
        @cm.last_name = params[:community][:last_name]
        @cm.save(:validate => false)
        session[:notice] = "Your Community Market updates were successful. Thanks for your partication.."
        redirect_to home_items_listing_url 
     end
     end
    end
  end
  
  
  def create_new_community
     @community = Community.new(params[:community])
      if @community.save(:validate =>true) && @community.errors.empty?
        session[:notice] = "Echo Market successful in creating your Community!  Welocome aboard." 
        return true
      else
        session[:notice] = "Echo Market error in creating new community"  
        return false
     end
     
end
  
   def activate
    reset_session
    
    @cm = params[:activation_code].blank? ? false : Community.find_by_activation_code(params[:activation_code])
    unless @cm.blank?
      unless @cm.activation_code.blank?
        if @cm.activate
          @current_user = @cm
          @cm_l = CommunityMember.find(:first, :readonly, :conditions => ["community_id = ?", @current_user.community_id])
          session[:user_id] = @cm_l.user_id 
          session[:community_id] = @current_user.community_id
          session[:user_type] = session[:register_type] = @current_user.user_type
          session[:community_name] = @current_user.community_name
          session[:user_alias] = (@cm_l.first_name.blank? ? @cm_l.alias : @cm_l.first_name + " " + (@cm_l.mi.blank? ? "": @cm_l.mi) + " " + @cm_l.last_name) 
          session[:notice] = @current_user.community_name + ", your registration activation is complete, and you are now logged in."
          redirect_to :controller=> "community", :action=>"advise", :id => @cm.community_id
        else
          session[:notice] = "Echo Market failure in saving record."
        end
      else
        @current_user = @cm
         @cm_l = CommunityMember.find(:first, :readonly, :conditions => ["community_id = ?", @current_user.community_id])
         session[:user_id] = @cm_l.user_id
        session[:community_id] = @current_user.community_id
        session[:user_type] = session[:register_type] = @current_user.user_type
        session[:community_name] = @current_user.community_name
        session[:user_alias] = (@cm_l.first_name.blank? ? @cm_l.alias : @cm_l.first_name + " " + (@cm_l.mi.blank? ? "": @cm_l.mi) + " " + @cm_l.last_name)
        session[:notice] = @current_user.community_name + ", you have already activated your registration, and you are now logged in."
      end
        session[:advise] = false
        redirect_to :controller=> "community_member", :action=>"list", :id => @cm.community_id
    else
      session[:notice] = "Seems that you may have not properly copied the Activation url provided in your email.  Please try again."
      redirect_to :controller=> "home", :action=>"items_listing"
    end
  end
  
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
