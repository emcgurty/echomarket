class Borrower < ActiveRecord::Base

  attr_accessible :addresses_attributes, :item_image_attributes, :primary_address_attributes, :alternative_address_attributes
  has_one :primary_address, :class_name => 'Address'
  has_one :alternative_address, :class_name => 'Address'
  has_many :addresses, dependent: :destroy
  has_one :item_image, dependent: :destroy
  has_one :item_condition
  has_one :category
  has_one :country
  has_one :us_state
  has_one :contact_describe
  has_one :user
  accepts_nested_attributes_for :item_image
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :primary_address
  accepts_nested_attributes_for :alternative_address
  before_create :get_borrower_primary_key_value

  protected
  
  def get_borrower_primary_key_value
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

