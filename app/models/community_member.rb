class CommunityMember < ActiveRecord::Base
  
  
  self.primary_key = :community_member_id
  belongs_to :community
  attr_accessor :first_name_h,:last_name_h, :mi_h, :alias_h, :community_member_id_h
  attr_accessible :first_name,:last_name, :mi, :alias, :community_id, :remote_ip, :is_creator, :date_updated, :date_deleted
  
  
end
