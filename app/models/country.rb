class Country < ActiveRecord::Base
  
  self.primary_key = :country_id
  
  belongs_to :lenders
  belongs_to :borrowers
  
end
