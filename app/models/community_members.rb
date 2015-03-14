class CommunityMembers < ActiveRecord::Base
  
  set_primary_key :community_member_id
  attr_accessible :first_name,:last_name, :mi, :alias, :community_id, :remote_ip, :is_creator
  
  
end
