class CommunityMember < ActiveRecord::Base
   
  belongs_to :community
  attr_accessible :first_name,:last_name, :mi, :alias, :community_id, :remote_ip, :is_creator, :date_updated, :date_deleted
  
  
end
