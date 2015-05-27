class Borrower < ActiveRecord::Base

  attr_accessor :primary_address
  attr_accessor :alternative_address
  
  attr_accessible :addresses_attributes, :item_image_attributes
  attr_accessible :is_active, :user_id, :describe_yourself, :other_describe_yourself, :organization_name, :displayBorrowerOrganizationName, :first_name, :mi, :last_name, :displayBorrowerName, 
                  :displayBorrowerAddress, :home_phone, :public_display_home_phone, :cell_phone, :public_display_cell_phone, :alternative_phone, :public_display_alternative_phone, 
                  :email_alternative, :borrower_contact_by_email, :borrower_contact_by_home_phone, :borrower_contact_by_cell_phone, :borrower_contact_by_alternative_phone, :borrower_contact_by_Facebook, 
                  :borrower_contact_by_LinkedIn, :borrower_contact_by_Twitter, :borrower_contact_by_Instagram,:borrower_contact_by_Other_Social_Media, 
                  :borrower_contact_by_Other_Social_Media_Access, :other_item_category, :notify_lenders, :item_description, :item_condition_id, :item_model, :item_count,
                  :goodwill, :age_18_or_more, :primary_address, :alternative_address, :item_image
  
  
  
  has_many :addresses, dependent: :destroy
  has_one :primary_address, :class_name => 'Address'
  has_one :alternative_address, :class_name => 'Address'
  has_one :item_image, dependent: :destroy
  accepts_nested_attributes_for :item_image
  accepts_nested_attributes_for :addresses
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

# Property.all.each do |f|
  # c = Contract.find_or_initialize_by(property_id: f.id)
  # c.update(some_attributes)
# end
