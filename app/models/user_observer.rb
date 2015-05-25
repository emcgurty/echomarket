class UserObserver < ActiveRecord::Observer
  
  observe :user


  def after_create(user)
    Notifier.signup_notification(user).deliver unless user.is_rapid == 1
  end

  def after_save(user)
     
    unless user.is_rapid == 1
    Notifier.activation(user).deliver if user.recently_activated?  
    Notifier.reset_password_notification(user).deliver if user.recently_reset? && user.recently_password_reset?
    Notifier.get_username_notification(user).deliver if user.recently_reset? && user.recently_username_get?
    end
    
    
  end

end
