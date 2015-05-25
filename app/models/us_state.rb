class UsState < ActiveRecord::Base
  
  belongs_to :community
  belongs_to :address
end
