class ItemCondition < ActiveRecord::Base
  
  self.primary_key = 'item_condition_id'
  
  belongs_to :lender
  belongs_to :borrower
  
end
