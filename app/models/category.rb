class Category < ActiveRecord::Base
  
  has_many :advertiser
  has_many :borrower
  has_many :lender

end
