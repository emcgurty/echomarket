class Borrower < ActiveRecord::Base
  
  
  attr_accessible :contact_describe_id, :first_name, :last_name, :displayBorrowerName, :displayBorrowerAddress, :useWhichContactAddress, :email_alternative, :borrower_contact_by_email, 
                   :category_id, :item_description, :item_condition_id, :other_item_category, :item_model, :item_count, :goodwill, :age_18_or_more, :is_active, :is_community, :date_created,
                   :approved, :remote_ip, :comment, :user_id, :other_describe_yourself, :organization_name, :displayBorrowerOrganizationName, :mi, :home_phone, :public_display_home_phone, 
                   :cell_phone, :public_display_cell_phone, :alternative_phone, :public_display_alternative_phone, :borrower_contact_by_home_phone, :borrower_contact_by_cell_phone, 
                   :borrower_contact_by_alternative_phone, :borrower_contact_by_Facebook, :borrower_contact_by_LinkedIn, :borrower_contact_by_Other_Social_Media, :borrower_contact_by_Twitter, 
                   :borrower_contact_by_Instagram, :borrower_contact_by_Other_Social_Media_Access, :notify_lenders, :date_updated
  has_many :addresses, dependent: :destroy
  has_many :item_images, dependent: :destroy
  
  
  attr_accessible :addresses_attributes, :item_images_attributes
  accepts_nested_attributes_for :item_images
  accepts_nested_attributes_for :addresses
   
  
  ###  Borrower tables contains i_c_id, c_i, c_i
  belongs_to :item_condition
  belongs_to :category
  belongs_to :country
  belongs_to :us_state
  belongs_to :contact_describe 
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

  ##   -> { where(id: 2) }  http://apidock.com/rails/v4.2.1/ActiveRecord/Associations/ClassMethods/belongs_to
  ##has_many :comments, -> { where(author_id: 1) }
  #has_many :primary_address, -> {where( address_type: 'primary' )}, :class_name => 'Address'
  #has_many :alternative_address, -> {where(address_type: 'alternative' )}, :class_name => 'Address'
##, :primary_address_attributes, :alternative_address_attributes, :user_attributes
#accepts_nested_attributes_for :primary_address
  #accepts_nested_attributes_for :alternative_address