class CommunityMembers < ActiveRecord::Base
  
  
  attr_accessible :first_name,:last_name, :mi, :alias, :community_id
end
