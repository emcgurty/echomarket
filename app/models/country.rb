class Country < ActiveRecord::Base
  
  self.primary_key = 'id'
  belongs_to :community
  belongs_to :address
  belongs_to :lender
  belongs_to :borrower
  
  
  
end
