class ApplicationController < ActionController::Base
 
  helper :all
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end



end
