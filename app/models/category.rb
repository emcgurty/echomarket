class Category < ActiveRecord::Base
  
  self.primary_key = 'id'
  
  has_many :advertiser
  has_many :borrower
  has_many :lender

end
