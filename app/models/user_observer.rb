class UserObserver < ActiveRecord::Observer
  
  observe :user

  def before_create(users)
    User.user_id = get_random
    
  end

  def after_create(users)
    Notifier.signup_notification(users).deliver unless User.is_rapid == 1
  end

  def after_save(users)

    unless User.is_rapid == 1
    Notifier.activation(users).deliver if User.recently_activated?  
    Notifier.reset_password_notification(users).deliver if User.recently_reset? && User.recently_password_reset?
    Notifier.get_username_notification(users).deliver if User.recently_reset? && User.recently_username_get?
    end
  end


  def get_random
    length = 36
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    @password = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @password
  end


end
