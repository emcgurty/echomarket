class ContactDescribe < ActiveRecord::Base
  
  self.primary_key = 'id'
  belongs_to :lender
  belongs_to :borrower
  
end
