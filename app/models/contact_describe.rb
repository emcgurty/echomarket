class ContactDescribe < ActiveRecord::Base
  
  self.primary_key = 'contact_describe_id'
  belongs_to :lender
  belongs_to :borrower
  
end
