class Address < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :borrower  # becuase add has borrower_id  
  belongs_to :lender
  
end
