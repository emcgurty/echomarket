class Category < ActiveRecord::Base
  
  belongs_to :advertiser
  belongs_to :borrower
  belongs_to :lender

end
