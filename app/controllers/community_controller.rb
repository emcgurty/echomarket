class CommunityController < ApplicationController
  
    
  def new
    @communities = Communities.new

    respond_to do |format|
      format.html # new.html.erb

    end
  end

  # GET /communities/1/edit
  def edit
    @communities = Communities.find(session[:community_id])
  end

  # POST /communities
  # POST /communities.json
  def create
    @communities = Communities.new(params[:communities])

    respond_to do |format|
      if @communities.save(:validate => true) && @communities.errors.empty?
        session[:notice] = "Your Echo Market Community record, #{params[:communities][:community_name]}, has been successfully created!  Please check your email, #{params[:communities][:email]}, to activate your account."
        format.html { redirect_to :controller => "home", :action => "items_listing" }

      else
        format.html { render action: "new" }

      end
    end
  end

  # PUT /communities/1
  # PUT /communities/1.json
  def update
    @communities = Communities.find(params[:commuity_id])

    respond_to do |format|
      if @communities.update_attributes(params[:Communities])
        session[:notice] = "Your updates have completed successfully."
        format.html { redirect_to :controller=> "home", :action => "items_listing"}

      else
        format.html { render action: "edit" }

      end
    end
  end

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    @communities = Communities.find(params[:id])
    @communities.destroy

    respond_to do |format|
      format.html { redirect_to communities_url }

    end
  end
  
    def logout

    @current_user = nil
    reset_session
    session[:notice] = "Thank you for exploring www.echomarket.org.  Please return soon."
    redirect_to home_items_listing_path

  end
  
  
   def activate
    session[:notice] = ''
    @cm = params[:activation_code].blank? ? false : Communities.find_by_activation_code(params[:activation_code])
    unless @cm.blank?
      unless @cm.activation_code.blank?
        if @cm.activate
          @current_user = @cm
          session[:user_id] = @current_user.user_id
          session[:community_id] = @current_user.community_id
          session[:user_type] = session[:register_type] = @current_user.user_type
          session[:community_name] = @current_user.community_name
          session[:user_alias] = @current_user.community_name
          session[:notice] = @current_user.community_name + ", your registration activation is complete, and you are now logged in."
        else
          session[:notice] = "Failure in saving record."
        end
      else
        @current_user = @cm
        session[:user_id] = @current_user.user_id
        session[:community_id] = @current_user.community_id
        session[:user_type] = session[:register_type] = @current_user.user_type
        session[:community_name] = @current_user.community_name
        session[:user_alias] = @current_user.community_name
        session[:notice] = @current_user.community_name + ", you have already activated your registration, and you are now logged in."
      end
      redirect_to :controller=> "community_member", :action=>"advise"
    else
      session[:notice] = "Seems that you may have not properly copied the Activation url provided in your email.  Please try again."
      redirect_to :controller=> "home", :action=>"items_listing"
    end
  end
  
   def forgot_community_name
    session[:background] = true
    if request.post?
      forgot('username')
    else
      @communities = Communities.new
    end
  end

  def forgot_community_password
    session[:background] = true
    if request.post?
      forgot('password')
    else
      @communities = Communities.new
    end
  end

  def forgot(which)
    session[:notice] = ''
    if request.post?
      @communities = Communities.find(:first, :conditions => ['email = ?', params[:users][:email]])

      unless @communities.blank?
        @communities.create_reset_code(which)
        if which == 'username'
          # respond_to do |format|
          Notifier.get_username_notification(@communities).deliver if @communities.recently_reset? && @communities.recently_username_get?
          #format.html
          session[:notice] = "Path to retrieve Community name sent to #{@communities.email}"
        #end
        else
          Notifier.reset_password_notification(@communities).deliver if @communities.recently_reset? && @communities.recently_password_reset?
          session[:notice] = "Path to reset password code sent to #{@communities.email}"
        end
        redirect_to home_items_listing_url

      else
        session[:notice] = "Email: '#{params[:communities][:email]}' does not exist in the Echo Market database."
        redirect_to home_items_listing_url

      end

    end
  # respond_to do |format|
  # format.html
  #end
  end

  def get_reset_community_password
    reset_session
    session[:background] = true
    session[:notice] = ''
    @communities = Communities.find(:first, :conditions => ["reset_code =?", params[:id]])
  end

  def reset_password

    @communities= Communities.find(:first, :conditions => ["reset_code =?", params[:communities][:reset_code]])
    unless @communities.blank?
      @myupdatehash = Hash.new
      @myupdatehash = [:password => params[:communities][:password], :password_confirmation => params[:communities][:password_confirmation]]
      @communities.update_attributes(@myupdatehash)
      @communities.delete_reset_code
      session[:notice] = "Password reset successfully for #{@communities.email}. Please login"
      redirect_to home_items_listing_url
    else
      session[:notice] = "There was an error in updating your password, please contact the Echo Market. Perhaps you are trying to update your password from an old email notification."
      redirect_to home_items_listing_url
    end

  end

end
