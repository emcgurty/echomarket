class Lender < ActiveRecord::Base
  
  
  has_one :primary_address, ->() do where( :address_type => :primary ) end, :class_name => 'Address'
  has_one :alternative_address, ->() do where( :address_type => :alternative ) end, :class_name => 'Address'
  has_many :addresses, dependent: :destroy
  has_many :item_image, dependent: :destroy
  has_many :user
  attr_accessible :addresses_attributes, :item_image_attributes, :primary_address_attributes, :alternative_address_attributes, :user_attributes
  accepts_nested_attributes_for :item_image
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :primary_address
  accepts_nested_attributes_for :alternative_address
  accepts_nested_attributes_for :user
  
  ###  Lender tables contains i_c_id, c_i, c_i
  belongs_to :item_condition
  belongs_to :category
  belongs_to :country
  belongs_to :us_state
  has_many :contact_describe
  has_many :user
 
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


# Stewart Mckinney: 
# has_many :addresses
# 
# has_many :primary_address, 
# ->() do
  # where( :type => :primary )
# end,
# :class_name => Address
# 
# This will make primary address accessible through addresses but also make it its own association ( so you can just pass that association to the form ).
# 
# Be aware that changes to one association will not be reflected in the other. So if you change "primary_address", before you reload, the object in addresses which corresponds to your primary address will not have the changes you made to primary address. After you save/reload, they will.
# 
# *changes to one association will not be reflected in the other until reload.
