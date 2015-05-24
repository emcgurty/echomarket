class Country < ActiveRecord::Base
  
  self.primary_key = :country_id
  
  belongs_to :community
  belongs_to :address
  
  
  
end
