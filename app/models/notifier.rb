require "#{Rails.application.root}/lib/tasks/lookup_values.rb"

class Notifier < ActionMailer::Base

  include LookupValues
  LookupMethods.load_values
  layout 'notifier'

  def comments_received(recipient, message, sent_at = Time.now)
    @subject = "The Echo Market Contact..."
    @recipients = recipient + ", " + LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    puts "lookup"
    puts LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @from = LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @sent_on = sent_at
    @comments = message
    @created_at =   sent_at
  end

 def signup_notification_community(communities)
    puts "inside signup_notification"   
    setup_email_community(communities)
    @subject    += ' Please activate your new account'
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/community/activate/#{communities.activation_code}/#{communities.user_id}"

  end
  
  def signup_notification(users)


    setup_email(users)
    @subject    += ' Please activate your new account'
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/user/activate/#{users.activation_code}/#{users.user_id}"

  end

  def activation(users)
    setup_email(users)
    @subject    += ' Your account has been activated!'
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}"

  end
  
    def community_activation(communities)
    setup_email_community(communities)
    @subject    += ' Your account has been activated!'
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}"

  end

  def reset_password_notification(users)
    setup_email(users)
    @subject    += ' Follow this link to reset your password'
    @url  = "http://"
    @url  = @url + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/user/get_reset_password/#{users.reset_code}"
  end

  def get_username_notification(users)
    setup_email(users)
    @subject    += ' Follow this link to learn your username'
    @url  = "http://"
    @url = @url  + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/user/get_username/#{users.reset_code}"
  end

def get_community_notification(communities)
    setup_email_community(communities)
    @subject    += ' Follow this link to learn your username'
    @url  = "http://"
    @url = @url  + "#{LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:url]}/communities/get_username/#{users.reset_code}"
  end
  private
  def setup_email(users)
    @recipients  = "#{users.email}"
    @from        = LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @subject     = "Message From www.echomarket.org. "
    @sent_on     = Time.now
    

  end
  def setup_email_community(communities)
    puts "inside setup_email"
    @recipients  = communities.email + ","  + LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @from        = LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @subject     = "Message From www.echomarket.org. "
    @sent_on     = Time.now
    
  end
  

  def do_contact(params, sent_at = Time.now)

    @subject = "Echo Market Contact... "
    @recipients = params[:email]
    @from = LookupValues::LookupMethods.lookupvalue[:echo_market_owner][:email]
    @message = message
    @sent_on = sent_at
    @body = body


  end

end
