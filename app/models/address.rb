class Address < ActiveRecord::Base
  # attr_accessible :title, :body
   
  has_one :country
  has_one :us_state
      
  
end
