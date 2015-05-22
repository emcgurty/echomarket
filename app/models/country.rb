class Country < ActiveRecord::Base
  
  self.primary_key = :country_id
  
  belongs_to :communities
  belongs_to :addresses
  
  
  
end
