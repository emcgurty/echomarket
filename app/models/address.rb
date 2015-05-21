class Address < ActiveRecord::Base
  # attr_accessible :title, :body
  self.primary_key = :address_id
  
  belongs_to :lender
  belongs_to :borrower
  
end
