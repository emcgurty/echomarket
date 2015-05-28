class Category < ActiveRecord::Base
  
  has_one :advertiser
  has_one :borrower
  has_one :lender

end
