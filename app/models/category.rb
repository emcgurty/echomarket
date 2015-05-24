class Category < ActiveRecord::Base
  
 self.primary_key = 'category_id'
 
  belongs_to :advertiser
  belongs_to :borrower
  belongs_to :lender

end
