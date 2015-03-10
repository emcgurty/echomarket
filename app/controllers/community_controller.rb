class CommunityController < ApplicationController
  
    
  def new
    @communities = Communities.new

    respond_to do |format|
      format.html # new.html.erb

    end
  end

  # GET /communities/1/edit
  def edit
    @communities = Communities.find(params[:id])
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
    @communities = Communities.find(params[:id])

    respond_to do |format|
      if @communities.update_attributes(params[:Communities])
        format.html { redirect_to @communities, notice: 'Communities was successfully updated.' }

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
   def activate
    session[:notice] = ''
    @user = params[:activation_code].blank? ? false : Communities.find_by_activation_code(params[:activation_code])
    unless @user.blank?
      unless @user.activation_code.blank?
        if @user.activate
          @current_user = @user
          session[:user_id] = @current_user.user_id
          session[:user_type] = @current_user.user_type
          session[:community_name] = @current_user.community_name
          session[:notice] = @current_user.community_name + ", your registration activation is complete, and you are now logged in."
        else
          session[:notice] = "Failure in saving record."
        end
      else
        @current_user = @user
        session[:user_id] = @current_user.user_id
        session[:user_type] = @current_user.user_type
        session[:community_name] = @current_user.community_name
        session[:notice] = @current_user.community + ", you have already activated your registration, and you are now logged in."
      end

    else
      session[:notice] = "Seems that you may have not properly copied the Activation url provided in your email.  Please try again."
    end

    redirect_to :controller=> "home", :action=>"items_listing"
  end
end
