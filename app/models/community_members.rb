class CommunityMembers < ActiveRecord::Base
  
  belongs_to :communities
  set_primary_key :community_member_id
  attr_accessor :first_name_h,:last_name_h, :mi_h, :alias_h, :community_member_id_h
  attr_accessible :first_name,:last_name, :mi, :alias, :community_id, :remote_ip, :is_creator
  
  
end
