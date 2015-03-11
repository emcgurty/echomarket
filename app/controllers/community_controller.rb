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
          session[:user_type] = @current_user.user_type
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
        session[:user_type] = @current_user.user_type
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
end
