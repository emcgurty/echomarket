class ApplicationController < ActionController::Base

  helper :all
  protect_from_forgery
  #before_filter :check_browser  
  # http://ruby-journal.com/how-to-block-old-ie-version-with-rails/
  # https://rubygems.org/gems/browser
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

 # private
# 
 # Browser = Struct.new(:browser, :version)
# 
 # SupportedBrowsers = [
 # Browser.new('Safari', '6.0.2'),
 # Browser.new('Firefox', '19.0.2'),
 # Browser.new('Internet Explorer', '9.0'),
 # Browser.new('Chrome', '25.0.1364.160')
 # ]
# 
 # def check_browser
 # user_agent = UserAgent.parse(request.user_agent)
 # unless SupportedBrowsers.detect { |browser| user_agent >= browser }
 # render text: 'Your browser is not supported!'
 # end
 # end


end
