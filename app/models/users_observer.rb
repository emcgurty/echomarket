class UsersObserver < ActiveRecord::Observer
  
  observe :users

  def before_create(users)
    users.user_id = get_random
    
  end

  def after_create(users)
    Notifier.signup_notification(users).deliver
  end

  def after_save(users)

    Notifier.activation(users).deliver if users.recently_activated?
    Notifier.deliver_reset_password_notification(users) if users.recently_reset? && users.recently_password_reset?
    Notifier.deliver_get_username_notification(users) if users.recently_reset? && users.recently_username_get?
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
