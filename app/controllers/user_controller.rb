class UserController < ApplicationController
  def edit
    unless params[:users].blank?
      begin
        @users = User.find(:first,  :conditions => ["user_id = ?", session[:user_id]])
        @myupdatehash = Hash.new
        @myupdatehash = [:user_type => params[:users][:user_type].to_s,
        :user_alias => params[:users][:user_alias].to_s,
        :email => params[:users][:email].to_s]
        @save_result = @User.update_attributes(@myupdatehash[0])
        @User.save(:validate => false)
        @current_user = @users
      rescue ActiveRecord::ActiveRecordError => msg
        session[:notice] = "Error in updating your user record with system generated message: " + msg
        redirect_to home_items_listing_url
      else
        session[:user_alias] = params[:users][:user_alias]
        session[:user_type] = params[:users][:user_type]
        session[:notice]  = "Your changes have been successful, " + params[:users][:user_alias].to_s
        redirect_to home_items_listing_url
      end
    else

      @users = User.find(:first, :conditions => ["user_id = ?", session[:user_id]])
    end
  end

 
 
  def delete_user_account
    @hold_alias = session[:user_alias]
    begin

      @ldelete = Lender.find(:all, :conditions => ["user_id = ?", session[:user_id]])
      @bdelete = Borrower.find(:all, :conditions => ["user_id = ?", session[:user_id]])
      @udelete = User.delete(session[:user_id])

      @ldelete.each do |val|
        Lender.delete(val.lender_item_id)

      end

      @bdelete.each do |val|
        Borrower.delete(val.borrower_item_id)

      end

    rescue Exception => msg
      reset_session
      session[:notice] = "Error in deleting your user record with system generated messages"

    else
      reset_session
      session[:notice]  = "#{@hold_alias}, your account has been deleted and all record associated with your Login have been deleted." 

    end
    redirect_to home_items_listing_path

  end

  def logout

    @current_user = nil
    reset_session
    session[:notice] = "Thank you for exploring www.echomarket.org.  Please return soon."
    redirect_to home_items_listing_path

  end

  def register
    reset_session
    session[:background] = true
    if session[:user_id].blank?
      session[:register_type] = (params[:type].blank? ? 'all': params[:type])
    end

    @users = User.new

  end

  def login
    
    if session[:notice]
      @hold_s = session[:notice]
    end
    reset_session
    session[:notice] = @hold_s
    session[:edit_user] = false
    session[:background] = true
    session[:register_type] = (params[:type].blank? ? 'all': params[:type])

    ### Create, update or validate login in
    if request.post?
     
      unless session[:user_id].blank?
        user_record
      else
        if params[:users][:community_name].blank?  && params[:users][:community_password].blank?
          show
        else
          show_community
        end
      end
    ### else we're are about to edit user
    else
      unless params[:id].blank?
        session[:edit_user] = true
        @users = User.find(params[:id])
      else
        @ucount = User.count
        if   @ucount == 0
          @users = User.new
          redirect_to :action => "register"
        else
          @users = User.new
        end
      end
    end
  end

  def show
    session[:login_notice] = ''
    
    if request.post?
      @current_user = User.find(:first, :readonly => true, :conditions=>['username = ?', params[:users][:username]])
      unless @current_user.blank?
        if @current_user.activation_code.blank? && @current_user.authenticated?(params[:users][:password])
          session[:user_id] = @current_user.user_id
          session[:user_type] = @current_user.user_type
          session[:user_alias] = @current_user.user_alias
          session[:email] = @current_user.email 
          @getUserType = (@current_user.user_type == 'both' ? "Lender/Borrower": @current_user.user_type ).upcase
          session[:notice] = "Welcome, #{@current_user.user_alias}, you are registered as a #{@getUserType}."
          redirect_to home_items_listing_url
        else
          unless @current_user.activation_code.blank?
            session[:notice] = "#{@current_user.username}, please check your email to activate your login."
            redirect_to home_items_listing_url
          else @current_user.authenticated?(params[:users][:password])
            session[:login_notice] = "We have entered an incorrect password."
            @users = User.new
          end
        end
      else
        session[:login_notice] = "Sorry about this but your username and/or password were not recognized by www.echomarket.org. Please try again. "
        @users = User.new
      end
    else
      @user = User.new
    end
  end

  def show_community
          
          session[:login_notice] = ''
          session[:notice] = ''
          @member_parse = ""
          @fin = ""
          @mn = ""
          @ln = ""
          @does_member_exist = true
            
                    @comm_name = params[:users][:community_name]
                    @current_user = Communities.find(:first, :readonly => true, :conditions=>['community_name = ?', @comm_name])
                  
                   
                    @member_parse = params[:users][:community_alias] unless params[:users][:community_alias].blank?
                    
                    
                      if @member_parse.blank?
                        @fin = (params[:users][:community_first_name].blank? ? "" : params[:users][:community_first_name].to_s)
                        @mn = (params[:users][:community_mi].blank? ? "" : params[:users][:community_mi].to_s)
                        @ln = (params[:users][:community_last_name].blank? ? "" : params[:users][:community_last_name].to_s)
                        @member_parse = @fin + @mn + @ln
                      end
                      
                      @does_member_exist = get_member_login_info(@current_user, params[:users]) if @current_user  && !@member_parse.blank? 
                    
                    if @current_user.blank?
                      puts "1"
                       session[:notice] = "Sorry about this, but your Community name, #{@comm_name}, was not recognized by www.echomarket.org. Please try again. "
                       redirect_to :action => "login"
                    elsif !@current_user.activation_code.blank?
                      puts "2" 
                       session[:notice] = session[:notice] + "#{@current_user.community_name}, please check your email to activate your login."
                       redirect_to :action => "login"
                    elsif @current_user.authenticated?(params[:users][:community_password]).blank?
                      puts "3"
                              session[:notice] = "We have entered an incorrect password."
                              redirect_to :action => "login"
                    elsif @current_user && (@does_member_exist == false)  
                          puts "4"
                             @member_parse = params[:users][:community_alias] unless params[:users][:community_alias].blank?
                             if @member_parse.blank?
                              @fin = (params[:users][:community_first_name].blank? ? "" : params[:users][:community_first_name].to_s)
                              @mn = (params[:users][:community_mi].blank? ? "" : params[:users][:community_mi].to_s)
                              @ln = (params[:users][:community_last_name].blank? ? "" : params[:users][:community_last_name].to_s)
                              @member_parse = @fin + " " + (@mn.blank? ? "" : @mn + " ") + @ln
                            end
                      
                          session[:notice] = "Echo Market was not able to find the member fullname or alias that you entered: #{@member_parse}.  Please either try again, or just login under your Community name and password."
                          redirect_to :action => "login" 
                    
                    elsif  @current_user  && (@does_member_exist  == true) 
                          puts '5'
                          @cm_creator = CommunityMember.find(:first, :readonly, :conditions => ["is_creator = 1 and community_id = ?", @current_user.community_id])
                           
                                session[:user_id] = @cm_creator.user_id if session[:user_id].blank?
                                if session[:user_alias].blank?
                                  unless @cm_creator.alias.blank?
                                    session[:user_alias] = @cm_creator.alias
                                  else
                                    session[:user_alias] = @cm_creator.first_name + (@cm_creator.mi.blank? ? "" : " " + @cm_creator.mi) + " " + @cm_creator.last_name       
                                  end
                                end
                               
                                session[:community_name] = @current_user.community_name
                                session[:user_type] = session[:register_type] = @current_user.user_type
                                session[:email] = @current_user.email  
                                session[:community_id] = @cm_creator.community_id    
                                @getUserType = (@current_user.user_type == 'both' ? "Lender/Borrower": @current_user.user_type ).upcase
                                session[:notice] = "Welcome, #{@current_user.community_name}, you are registered as a Echo Market Community #{@getUserType}.  All Echo Market features of borrowing and lending will pertain only to your community."
                                redirect_to home_items_listing_url
                     
                     end      
           
  end  #def


 
    
  def user_record
    session[:notice] = ''

    @record_success = true
    if request.post?
      if params[:commit] == "Submit Updates"
        @record_success = update
        if @record_success
          session[:notice] = @current_user.user_alias + ", your updates have been successful"
          redirect_to home_items_listing_url
        end
      elsif params[:commit] == "register"
        @record_success = (session[:edit_user] ? update : create)
        if @record_success
          if session[:edit_user]
            session[:notice] = "Thanks for updating your information."
          else
            session[:notice] = "Thanks for signing up! Please check your email to activate your account."
          end
          redirect_to home_items_listing_url
        end
      end
    end
    return @record_success
  end

  def create
    session[:notice] = ''
    username_ =   params[:users][:username]
    password_ =   params[:users][:password]
    password_confirmation_ = params[:users][:password_confirmation]
    email_ = params[:users][:email]
    remote_ip_ =   params[:users][:remote_ip]
    user_type_ = (params[:users][:user_type].blank? ? 'guest' : params[:users][:user_type])
    user_alias_ =   params[:users][:user_alias]
    @users = User.new(
      :username =>   username_,
      :password=>    password_,
      :password_confirmation => password_confirmation_,
      :email => email_,
      :approved => 0,
      :remote_ip =>   remote_ip_,
      :user_type => user_type_,
      :user_alias => user_alias_)
    if @User.save(:validate => true) && @User.errors.empty?
      session[:reset] = true
      session[:notice] = "Thanks for signing up! Please check your email, #{params[:users][:email]}, to activate your account."
      redirect_to home_items_listing_url
    else
      render :action => 'register'
    end

  end

  def update
    session[:notice] = ''
    myupdatehash = Hash.new
    params[:users].each do |val|
      myupdatehash[val[0]] = val[1] unless val[1].blank? || val[0] == 'user_id'
    end

    begin
      @user = User.find(:first, :conditions=>['user_id = ?', params[:users][:user_id]])
      @user.update_attributes(myupdatehash)

      @user.delete_reset_code
    rescue Exception => msg
      session[:notice] = "Error in updating your record with system generated message: " + msg
      render :show
    else
      if @user.save(true)
        @current_user = @user
        session[:user_id] = @current_user.user_id
        session[:user_type] = @current_user.user_type
        session[:user_alias] = @current_user.user_alias
      return true
      else
      return false
      end
    end
  end

  def activate
    reset_session
    session[:notice] = ''
    @user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    unless @user.blank?
      unless @user.activation_code.blank?
        if @user.activate
          @current_user = @user
          session[:user_id] = @current_user.user_id
          session[:user_type] = @current_user.user_type
          session[:user_alias] = @current_user.user_alias
          session[:notice] = @current_user.user_alias + ", your registration activation is complete, and you are now logged in."
          
        else
          session[:notice] = "Failure in saving record."
        end
      else
        @current_user = @user
        session[:user_id] = @current_user.user_id
        session[:user_type] = @current_user.user_type
        session[:user_alias] = @current_user.user_alias
        session[:notice] = @current_user.user_alias + ", you have already activated your registration, and you are now logged in."
      end

    else
      session[:notice] = "Seems that you may have not properly copied the Activation url provided in your email.  Please try again."
    end

    redirect_to :controller=> "home", :action=>"items_listing"
  end

  def forgot_username
    session[:background] = true
    if request.post?
      forgot('username')
    else
      @users = User.new
    end
  end

  def forgot_password
    session[:background] = true
    if request.post?
      forgot('password')
    else
      @users = User.new
    end
  end

  def forgot(which)
    session[:notice] = ''
    if request.post?
      @user = User.find(:first, :conditions => ['email = ?', params[:users][:email]])

      if !(@user.blank?)
        @user.create_reset_code(which)
        if which == 'username'
          # respond_to do |format|
          Notifier.get_username_notification(@user).deliver if @user.recently_reset? && @user.recently_username_get?
          #format.html
          session[:notice] = "Path to retrieve username sent to #{@user.email}"
        #end
        else
          Notifier.reset_password_notification(@user).deliver if @user.recently_reset? && @user.recently_password_reset?
          session[:notice] = "Path to reset password code sent to #{@user.email}"
        end
        redirect_to home_items_listing_url

      else
        session[:notice] = "Email: '#{params[:users][:email]}' does not exist in the Echo Market database."
        redirect_to home_items_listing_url

      end

    end
  # respond_to do |format|
  # format.html
  #end
  end

  def get_reset_password
    session[:background] = true
    session[:notice] = ''
    @users = User.find(:first, :conditions => ["reset_code =?", params[:id]])
  end

  def reset_password

    @users = User.find(:first, :conditions => ["reset_code =?", params[:reset_code]])
    if @users
      @myupdatehash = Hash.new
      @myupdatehash = [:password => params[:users][:password], :password_confirmation => params[:users][:password_confirmation]]
      @User.update_attributes(@myupdatehash[0])
      @User.delete_reset_code
      session[:notice] = "Password reset successfully for #{@User.email}. Please login"
      redirect_to home_items_listing_url
    else
      session[:notice] = "There was an error in updating your password, please contact the Echo Market. Perhaps you are trying to update your password from an old email notification."
      redirect_to home_items_listing_url
    end

  end

  def get_username
    session[:notice] = ''
    @user = User.find_by_reset_code(params[:id]) unless params[:id].blank?
    if @user
      @user.delete_reset_code
      session[:notice] = "Your username is #{@user.username}. Please login."
      redirect_to home_items_listing_url
    else
      session[:notice] = "Your username was previously reported to you. Please try to login again."
      redirect_to home_items_listing_url
    end

  end
  
  
    
  def get_member_login_info(c, pm)
   puts "get member_login"
   
   puts "pm[:community_alias]"
   puts pm[:community_alias]
   return_result = true
   
   @b_find_member_name = find_member_name(c, pm) unless pm[:community_first_name].blank? && pm[:community_mi].blank? && pm[:community_first_name].blank?
      
   if  @b_find_member_name.blank?
       puts "sb false"
       @b_find_member_alias = find_member_alias(c, pm) unless pm[:community_alias].blank?
       
        
   end
   
   
   
   if (@b_find_member_name.blank?  &&  @b_find_member_alias.blank?)

      return_result = false
   end
                     
   return return_result

end

 def find_member_name(c, pm)
       
       @cm_nom = CommunityMember.new
       @cm_m = CommunityMember.new
       if pm[:community_mi].blank?
              @cm_nom = CommunityMember.find(:first, :readonly, :conditions =>["community_id = ? and first_name = ? and last_name = ?",
                c.community_id, pm[:community_first_name], pm[:community_last_name]])
       else
              @cm_m = CommunityMember.find(:first, :readonly, :conditions =>["community_id = ? and first_name = ? and last_name = ? and mi = ?",
                c.community_id, pm[:community_first_name], pm[:community_last_name], pm[:community_mi]])
        end
        unless @cm_nom.blank? && @cm_m.blank?
            unless @cm_nom.blank?
              session[:user_id] = @cm_nom.community_member_id
              session[:user_alias] = pm[:community_first_name] + " " + pm[:community_last_name]
              @r_success = @cm_nom
            end
            unless @cm_m.blank?
              session[:user_id] = @cm_m.community_member_id
              session[:user_alias] = pm[:community_first_name] + " " + pm[:community_mi] + " " + pm[:community_last_name]
             @r_success = @cm_m
       end
       end
            return @r_success
    end
    
      def find_member_alias(c, pm)
           
           @cm_a = CommunityMember.new
           unless pm[:community_alias].blank?
   
              @cm_a = CommunityMember.find(:first, :readonly, :conditions =>["community_id = ? and alias = ?",
                c.community_id, pm[:community_alias]])
   
   
            end

            unless @cm_a.blank?
              session[:user_id] = @cm_a.community_member_id
              session[:user_alias] = pm[:community_alias]
              @r_success = @cm_a   
            end
                       
            return @r_success
       end

end