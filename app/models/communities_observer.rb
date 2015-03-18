class CommunitiesObserver < ActiveRecord::Observer
  
  observe :communities

  def before_create(communities)
    communities.community_id = get_random
  end

  def after_create(communities)
    begin
      Notifier.signup_notification_community(communities).deliver
     rescue  Exception => e
    puts e.message
    puts "signup_notification_community"        
     
    end  
  end

  def after_save(communities)

   begin
    Notifier.community_activation(communities).deliver if communities.recently_activated?
    Notifier.reset_community_password_notification(communities).deliver if communities.recently_reset? && communities.recently_password_reset?
    Notifier.get_community_notification(communities).deliver if communities.recently_reset? && communities.recently_community_name_get?
   rescue  Exception => e
    puts e.message
    puts "after_save"   
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
