class Borrower < ActiveRecord::Base

  has_many :addresses, dependent: :destroy
  has_many :item_image, dependent: :destroy
  has_many :user
 
  attr_accessible :describe_yourself, :first_name, :last_name, :displayBorrowerName, :displayBorrowerAddress, :useWhichContactAddress, :email_alternative, :borrower_contact_by_email, 
                   :category_id, :item_description, :item_condition_id, :other_item_category, :item_model, :item_count, :goodwill, :age_18_or_more, :is_active, :is_community, :date_created,
                   :approved, :remote_ip, :comment
  
  attr_accessible :addresses_attributes, :item_image_attributes, :user_attributes
  accepts_nested_attributes_for :item_image
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :user
  
  
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