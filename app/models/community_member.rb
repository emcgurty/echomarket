class CommunityMember < ActiveRecord::Base
   
  belongs_to :community
  attr_accessible :user_id, :remote_ip, :first_name, :mi,  :last_name, :alias, :is_active, :date_created, :date_updated, :date_deleted ,:is_creator
  before_create :get_user_id
  
  protected
  
    def get_user_id
     if self.id.blank?
       self.id =  get_random
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
