class Address < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :borrower  # becuase add has borrower_id  
  belongs_to :lender
  scope :primary_address, where(:address_type  => 'primary') 
  scope :alternative_address, where(:address_type  => 'alternative')
end
