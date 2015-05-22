class UsState < ActiveRecord::Base
  
  self.primary_key = :state_id
  belongs_to :communities
  belongs_to :addresses
end
