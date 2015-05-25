class Borrower < ActiveRecord::Base

  attr_accessor :primary_address
  attr_accessor :alternative_address
  
  attr_accessible :addresses_attributes, :item_image_attributes
  attr_accessor :found_zip_codes
  has_many :addresses, dependent: :destroy
  has_one :primary_address, :class_name => 'Address'
  has_one :alternative_address, :class_name => 'Address'
    
  has_one :item_image, dependent: :destroy
  has_one :item_condition
  has_one :category
  has_one :country
  has_one :us_state
  has_one :contact_describe
  has_one :user
  
  accepts_nested_attributes_for :item_image
  accepts_nested_attributes_for :item_condition
  accepts_nested_attributes_for :category
  accepts_nested_attributes_for :country
  accepts_nested_attributes_for :us_state
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :addresses
    
  before_create :get_borrower_primary_key_value

  protected
  

  def get_borrower_primary_key_value
    if self.id.blank?
    self.id = get_random
    end
  end

  def get_random
    length = 36
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    @id = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @id
  end
end

# Property.all.each do |f|
  # c = Contract.find_or_initialize_by(property_id: f.id)
  # c.update(some_attributes)
# end
