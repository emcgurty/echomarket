class CommunityObserver < ActiveRecord::Observer
  
  observe :community

  def before_create(community)
    puts "before_create called on update"
    community.id = get_random if community.id.blank?
  end

  def after_create(community)
    begin
      Notifier.signup_notification_community(community).deliver
     rescue  Exception => e
    puts e.message
    puts "signup_notification_community"        
     
    end  
  end

  def after_save(community)

   begin
    Notifier.community_activation(community).deliver if community.recently_activated?
    Notifier.reset_community_password_notification(community).deliver if community.recently_reset? && community.recently_password_reset?
    Notifier.get_community_notification(community).deliver if community.recently_reset? && community.recently_community_name_get?
   rescue  Exception => e
    puts e.message
    puts "after community save"   
       
  end
end

  def get_random
    length = 40
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    @id = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @id
  end


end
