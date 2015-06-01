require "#{Rails.application.root}/lib/tasks/lookup_values.rb"

class Notifier < ActionMailer::Base

  include LookupValues
  LookupMethods.load_values
  layout 'notifier'

  def notify_rapid(user)
      puts "rapid user email sent"  
     @subject = "Welcome Rapid Echo Market participant"
     @recipients = user.email + ", " + LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
     @from = LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
     @user_type = user.user_type
     @user_alias = user.user_alias
     @email = user.email
   end
   
    def notify_advertiser(ad)
    @subject = "Welcome Echo Market Advertiser"
    @recipients = ad.advertiser_email + ", " + LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @from = LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @email = ad.advertiser_email
    @title = ad.title
    @description = ad.description
    @url = ad.advertiser_url
    @advertiser_id = ad.id
   end
  
  
  def comments_received(recipient, message, sent_at = Time.now)
    @subject = "The Echo Market Contact..."
    @recipients = recipient + ", " + LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @from = LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @sent_on = sent_at
    @comments = message
    @created_at =   sent_at
  end

 def signup_notification_community(community)
    setup_email_community(community)
    @subject    += ' Please activate your new account'
    
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/community/activate/#{community.activation_code}/#{community.id}"
    puts @url 
    @community_name = community.community_name
    @password =  community.password

  end
  
  def signup_notification(user)

    setup_email(user)
    @subject    += ' Please activate your new account'
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/user/activate/#{user.activation_code}/#{user.id}"
    @username = user.username
    @password =  user.password

  end

  def activation(user)
    setup_email(user)
    @subject    += ' Your account has been activated!'
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}"

  end
  
    def community_activation(community)
    setup_email_community(community)
    @subject    += ' Your account has been activated!'
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}"
    @community_name = community.community_name

  end

  def reset_password_notification(user)
    setup_email(user)
    @subject    += ' Follow this link to reset your password'
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/user/get_reset_password/#{user.reset_code}"
  end

  def reset_community_password_notification(community)
    setup_email_community(community)
    @subject    += ' Follow this link to reset your password'
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/community/get_reset_community_password/#{community.reset_code}"
  end

  def get_username_notification(user)
    setup_email(user)
    @subject    += ' Follow this link to learn your username'
    @url  = "http://"
    @url = @url  + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/user/get_username/#{user.reset_code}"
  end

def get_community_notification(community)
    setup_email_community(community)
    @subject    += ' Follow this link to learn your Community Name'
    @url  = "http://"
    @url = @url  + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/community/get_community_name/#{community.reset_code}"
  end
  
  private
  
  def setup_email(user)
    @recipients  = "#{user.email}" + ", " + LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @from        = LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @subject     = "Message From www.echomarket.org. "
    @sent_on     = Time.now
    

  end
  def setup_email_community(community)
    @recipients  = community.email + ","  + LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @from        = LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @subject     = "Message From www.echomarket.org. "
    @sent_on     = Time.now
    
  end
  

  def do_contact(params, sent_at = Time.now)

    @subject = "Echo Market Contact... "
    @recipients = params[:email].to_s + ", " + LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @from = LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @message = message
    @sent_on = sent_at
    @body = body


  end

end
