class CommunityMembersObserver < ActiveRecord::Observer
  
  observe :community_members

  def before_create(community_members)
    community_members.community_member_id = get_random
    community_members.user_id = get_random
    
  end

  # def after_create(communities)
    # Notifier.signup_notification_community(communities).deliver
  # end
# 
  # def after_save(communities)
# 
    # Notifier.activation(communities).deliver if communities.recently_activated?
    # Notifier.deliver_reset_password_notification(communities) if communities.recently_reset? && communities.recently_password_reset?
    # Notifier.deliver_get_community_notification(communities) if communities.recently_reset? && communities.recently_community_name_get?
  # end


  def get_random
    length = 36
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    @password = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @password
  end


end
