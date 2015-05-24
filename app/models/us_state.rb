class UsState < ActiveRecord::Base
  
  self.primary_key = :us_state_id
  belongs_to :community
  belongs_to :address
end
