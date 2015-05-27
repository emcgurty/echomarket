class Lender < ActiveRecord::Base
  
  attr_accessible :addresses_attributes, :item_image_attributes
  has_one :item_image, dependent: :destroy
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :item_image
  accepts_nested_attributes_for :addresses
  
  before_create :get_lender_primary_key_value

  protected
  
  def get_lender_primary_key_value
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
# has_one :primary_address, 
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
