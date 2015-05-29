class Address < ActiveRecord::Base
  
  attr_accessible :lender_id, :borrower_id, :address_line_1, :address_line_2, :postal_code, :city, :province, :us_state_id, :region, :country_id, :address_type
                                     
                     
  belongs_to :borrower  # becuase add has borrower_id  
  belongs_to :lender
  scope :primary_address, where(:address_type  => 'primary') 
  scope :alternative_address, where(:address_type  => 'alternative')
  before_create :get_primary_key_value
  
  protected

    
  def get_primary_key_value
    if self.id.blank?
      self.id = get_random
    end  
  end
  
    def get_random
    length = 40
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    @id = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @id
  end
end
