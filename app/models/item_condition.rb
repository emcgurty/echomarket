class ItemCondition < ActiveRecord::Base
  
  belongs_to :lender
  belongs_to :borrower
  
end
