class Lender < ActiveRecord::Base
  self.primary_key = :lender_item_id
  attr_accessor :found_zip_codes
  attr_accessible :addresses_attributes, :itemimage_attributes
  has_one :itemimage
  has_one :itemcondition
  has_one :category
  has_one :country
  has_one :us_state
  has_one :contactdescribe
  has_one :user
  has_many :addresses
  accepts_nested_attributes_for :itemcondition
  accepts_nested_attributes_for :category
  accepts_nested_attributes_for :country
  accepts_nested_attributes_for :us_state
  accepts_nested_attributes_for :itemcondition
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :user
  
  before_create :get_lender_primary_key_value

  protected

  def get_lender_primary_key_value
    if self.lender_item_id.blank?
    self.lender_item_id = get_random
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
