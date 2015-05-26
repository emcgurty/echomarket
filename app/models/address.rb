class Address < ActiveRecord::Base
  # attr_accessible :title, :body
   
  has_one :country
  has_one :us_state
  has_one :item_image
  belongs_to :borrower    
  belongs_to :lender
  
end
