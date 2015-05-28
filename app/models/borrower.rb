class Borrower < ActiveRecord::Base

  has_one :primary_address, ->() do where( :address_type => :primary ) end, :class_name => 'Address'
  has_one :alternative_address, ->() do where( :address_type => :alternative ) end, :class_name => 'Address'
  has_many :addresses, dependent: :destroy
  has_many :item_image, dependent: :destroy
  has_many :user
  attr_accessible :addresses_attributes, :item_image_attributes, :user_attributes, :primary_address_attributes, :alternative_address_attributes, :user_attributes
  accepts_nested_attributes_for :item_image
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :primary_address
  accepts_nested_attributes_for :alternative_address
  accepts_nested_attributes_for :user
  
  ###  Borrower tables contains i_c_id, c_i, c_i
  belongs_to :item_condition
  belongs_to :category
  belongs_to :country
  belongs_to :us_state
  belongs_to :contact_describe 
  
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

