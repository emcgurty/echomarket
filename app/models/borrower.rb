class Borrower < ActiveRecord::Base

  self.primary_key = :borrower_item_id
  attr_accessible :addresses_attributes, :itemimage_attributes
  attr_accessor :found_zip_codes
  has_one :itemimage
  has_one :itemcondition
  has_one :category
  has_one :country
  has_one :us_state
  has_one :contactdescribe
  has_one :user
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :itemcondition
  accepts_nested_attributes_for :category
  accepts_nested_attributes_for :country
  accepts_nested_attributes_for :us_state
  accepts_nested_attributes_for :itemcondition
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :addresses
    
  before_create :get_borrower_primary_key_value

  protected

  def get_borrower_primary_key_value
    if self.borrower_item_id.blank?
    self.borrower_item_id = get_random
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
