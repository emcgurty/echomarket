class CommunityController < ApplicationController
  
    
  def new
    @communities = Community.new
     respond_to do |format|
      format.html # new.html.erb

    end
  end

  # GET /communities/1/edit
  def edit
    if params[:communities]
      update
    else
      @communities = Community.find(session[:community_id])
    end   
  end

  # POST /communities
  # POST /communities.json
  def create
    session[:notice] = ''
    @communities = Community.new(params[:communities])
    respond_to do |format|
      
      if @communities.save(:validate =>false)
        @cm = CommunityMember.new(
        :community_id => @communities.community_id, 
        :first_name => @communities.first_name, 
        :mi => @communities.mi,:last_name => @communities.last_name, :remote_ip => @communities.remote_ip, :date_created => Time.now, :is_active => 1, :is_creator => 1)
        if @cm.save(:validate => false) 
          session[:notice] = "Your Echo Market Community record, #{params[:communities][:community_name]}, has been successfully created!  Please check your email, #{params[:communities][:email]}, to activate your account."
          format.html { redirect_to :controller => "home", :action => "items_listing" }
        else
          session[:notice]= "Error in creating Community record"
          format.html { render :action => "new" }  
          
        end
      else
        format.html { render :action => "new" }
      end  #ends if saved
    end # ends do
  end  # ends def
 
 
 
  # PUT /communities/1
  # PUT /communities/1.json
# PUT /communities/1
  # PUT /communities/1.json
  def update
    session[:notice] = ''
    if params[:id]
      myupdatehash = Hash.new
      if params[:communities]
        @c = params[:communities]
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
                        :us_state_id=>@c[:us_state_id], 
                        :home_phone=>@c[:home_phone], 
                        :cell_phone => @c[:cell_phone] ]

     puts myupdatehash[0].to_yaml
     @communities = Community.find(params[:id])
     if @communities.update_attributes(myupdatehash[0]) && @communities.errors.empty? 
        @cm = CommunityMember.find(:first, :conditions => ["community_id = ? and is_creator = 1",params[:id] ])
        @cm.first_name = params[:communities][:first_name]
        @cm.mi = params[:communities][:mi]
        @cm.last_name = params[:communities][:last_name]
        @cm.save(:validate => false)
        session[:notice] = "Your Community Market updates were successful. Thanks for your partication.."
        redirect_to home_items_listing_url 
     end
     end
    end
  end
  

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    reset_session
        
    begin
    Community.delete(params[:id])
    @cm = CommunityMember.find(:all, :conditions => ["community_id = ?", params[:id]])
      @cm.each do |val|
       CommunityMember.delete(val.community_member_id)
      end 
       session[:notice] = "Your Community Record with associated members, if any beyond Community creator member, has been deleted from the Echo Market database."
       redirect_to home_items_listing_url
    rescue 
        session[:notice] = "Echo Market has experienced an error in deleting your Community Market record. Please refresh your browser, and try again. Otherwise if this matter persists, please contact Echo Market."
        redirect_to home_items_listing_url  
    end
    
  end
  
    def logout

    @current_user = nil
    reset_session
    session[:notice] = "Thank you for exploring www.echomarket.org.  Please return soon."
    redirect_to home_items_listing_path

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
        else
          session[:notice] = "Failure in saving record."
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
        redirect_to :controller=> "community_member", :action=>"m_list", :id => @cm.community_id
    else
      session[:notice] = "Seems that you may have not properly copied the Activation url provided in your email.  Please try again."
      redirect_to :controller=> "home", :action=>"items_listing"
    end
  end
  
  # POST /communities
  # POST /communities.json
  def forgot_community_name
    session[:background] = true
    if request.post?
      forgot('community_name')
    else
      @communities = Community.new
    end
  end

  def forgot_community_password
    session[:background] = true
    if request.post?
      forgot('password')
    else
      @communities = Community.new
    end
  end

  def forgot(which)
   
    session[:notice] = ''
    if request.post?
      @communities = Community.find(:first, :conditions => ['email = ?', params[:communities][:email]])

      unless @communities.blank?
        @communities.create_reset_code(which)
        if which == 'community_name'
          # respond_to do |format|
          Notifier.get_community_notification(@communities).deliver if @communities.recently_reset? && @communities.recently_community_name_get?
          #format.html
          session[:notice] = "Path to retrieve Community name sent to #{@communities.email}"
        #end
        else
          Notifier.reset_community_password_notification(@communities).deliver if @communities.recently_reset? && @communities.recently_password_reset?
          session[:notice] = "Path to reset password code sent to #{@communities.email}"
        end
        redirect_to home_items_listing_url

      else
        session[:notice] = "Email: '#{params[:communities][:email]}' does not exist in the Echo Market database."
        redirect_to home_items_listing_url

      end

    end  #end def
    
  # respond_to do |format|
  # format.html
  #end
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

    @communities= Community.find(:first, :conditions => ["reset_code =?", params[:reset_code]])
    unless @communities.blank?
      @myupdatehash = Hash.new
      @myupdatehash = [:password => params[:communities][:password], :password_confirmation => params[:communities][:password_confirmation]]
      @communities.update_attributes(@myupdatehash[0])
      @communities.delete_reset_code
      session[:notice] = "Password reset successfully for #{@communities.email}. Please login"
      redirect_to home_items_listing_url
    else
      session[:notice] = "There was an error in updating your password, please contact the Echo Market. Perhaps you are trying to update your password from an old email notification."
      redirect_to home_items_listing_url
    end

  end

  def get_reset_community_password
    session[:background] = true
    @communities = Community.find(:first, :conditions => ["reset_code =?", params[:id]])
  end
  
  ####  COMMUNITY MEMBERS DEFS
  
    def m_list
      session[:background] = true
      @community_members = CommunityMember.find(:all, :conditions => ["community_id = ?", session[:community_id]])
  end

  # # POST /community_members
  # # POST /community_members.json
  # def create
# 
    # @community_members = CommunityMember.new(params[:community_members])
#     
    # respond_to do |format|
#       
      # if @community_members.save && @community_members.errors.empty? 
        # if params[:commit] == 'Add'
          # format.html { redirect_to :action=>'m_list' }
#        
        # end
#       
      # else
        # format.html { render :action => "new" }
# 
      # end
    # end
  # end

 # POST /community_members
  # POST /community_members.json
  def add
  #Parameters: {"utf8"=>"?", "authenticity_token"=>"8b3H95PyT131qgJxSIR9+19VxS9A4MyV579W9KywLvU=", "community_members"=>{"first_name_h"=>"Liz", "mi_h"=>"m", "last_name_h"=>"mcgurty", "alias_h"=>"", "first_name"=>"d", "mi"=
  #>"m", "last_name"=>"l", "alias"=>"", "is_creator"=>"0"}, "commit"=>"Add", "view"=>"m_list"}
    myaddhash = Hash.new
    myaddhash = [:community_id => session[:community_id], :first_name => params[:community_members][:first_name], 
    :mi=>params[:community_members][:mi], :last_name => params[:community_members][:last_name], 
    :alias=> params[:community_members][:alias], :is_creator => 0, :remote_ip => params[:community_members][:remote_ip]]

    @community_members = CommunityMember.new(myaddhash[0])

    respond_to do |format|
      if @community_members.save
        format.html { redirect_to :action=>'m_list'}

      else
        session[:notice]  = "Echo Market error in adding new community member."
        format.html { redirect_to :action=>'m_list'}
      end
    end
  end
  
  # # POST /community_members
  # # POST /community_members.json
  # def remove
#     
    # begin
      # CommunityMember.delete(params[:id])
      # redirect_to :action=>'m_list'
    # rescue 
        # session[:notice] = 'Echo Market application error in removing your selected member.'
        # redirect_to :action=>'m_list'
    # end
#     
  # end

  
  # PUT /community_members/1
  # PUT /community_members/1.json :  :       /*  /*    match 'community_member/update_row/(:fi)/(:m)/(:la)/(:al)/(:ci)/(:com_id)/(:is_c)'=> "community_member#update_row", :as=> :community_member_update_row */ */
  def update_row
    @community_member = CommunityMember.find(params[:ci])
    
    unless @community_member.blank?
      myupdatehash = Hash.new
       if (params[:is_c] == '1')
            my_alias_str = params[:fi] + (params[:m].blank? ? "" : params[:m]) + params[:la]
           myupdatehash = [:first_name => params[:fi], :mi => params[:m],:last_name => params[:la], :alias => my_alias_str, :date_updated=> Time.now]
       else
           myupdatehash = [:first_name => params[:fi], :mi => params[:m],:last_name => params[:la], :alias => params[:al], :date_updated=> Time.now]
       end      
    end

    
      if @community_member.update_attributes(myupdatehash[0])
        if (params[:is_c] == '1')
          @c = Community.find(params[:com_id])
          @c.first_name = params[:fi]
          @c.mi = params[:m]
          @c.last_name = params[:la]
          @c.date_updated = Time.now
          @c.save(:validate => false)
                 
        end
        redirect_to :action=>'m_list' , :id => params[:ci]
      else
        session[:notice] = "The Echo Market Application encountered an error in updating your selected Community Member row."        
        redirect_to :action=>'m_list' , :id => params[:ci]
      end
    
 
 
  end


  # # DELETE /community_members/1
  # # DELETE /community_members/1.json
  # def destroy
    # @community_member = CommunityMember.find(params[:id])
    # @community_member.destroy
# 
    # respond_to do |format|
      # format.html { redirect_to community_members_url }
# 
    # end
  # end

end
