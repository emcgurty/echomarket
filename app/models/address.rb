class Address < ActiveRecord::Base
  # attr_accessible :title, :body
  self.primary_key = :address_id
  
  has_one :country
  has_one :usState
      
  
end
