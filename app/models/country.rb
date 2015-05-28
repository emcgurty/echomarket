class Country < ActiveRecord::Base
  
  belongs_to :community
  belongs_to :address
  belongs_to :lender
  belongs_to :borrower
  
  
  
end
