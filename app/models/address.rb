class Address < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :borrower    
  belongs_to :lender
  
end
