class UsState < ActiveRecord::Base
  
  self.primary_key = :state_id
  belongs_to :lender
  belongs_to :borrower
end
