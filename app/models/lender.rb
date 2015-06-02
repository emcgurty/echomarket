class Lender < ActiveRecord::Base
  
  
attr_accessible :contact_describe_id, :other_describe_yourself,:first_name,:mi, :last_name,:displayLenderName, :displayLenderAddress,:home_phone, :cell_phone, :alternative_phone,
                :public_display_home_phone,:public_display_cell_phone,:public_display_alternative_phone,:useWhichContactAddress,:email_alternative,:borrower_contact_by_email,
                :borrower_contact_by_home_phone, :borrower_contact_by_cell_phone,:borrower_contact_by_alternative_phone, :borrower_contact_by_Facebook,:borrower_contact_by_Twitter, 
                :borrower_contact_by_Instagram, :borrower_contact_by_LinkedIn,:borrower_contact_by_Other_Social_Media, :borrower_contact_by_Other_Social_Media_Access,
                :b_comes_to_which_address,:meetBorrowerAtAgreedL2B,:willDeliverToBorrowerPreferredL2B,:thirdPartyPresenceL2B,:lenderThirdPartyChoiceL2B,:agreedThirdPartyChoiceL2B,:b_returns_to_which_address,:meetBorrowerAtAgreedB2L,
                :willPickUpPreferredLocationB2L,:thirdPartyPresenceB2L,:lenderThirdPartyChoiceB2L,:agreedThirdPartyChoiceB2L,
                :borrowerChoice,:category_id,:other_item_category,:item_model,:item_description,:item_count,:for_free,:available_for_purchase,:available_for_purchase_amount,
                :small_fee,:small_fee_amount,:available_for_donation,:donate_anonymous,:trade,:trade_item,:agreed_number_of_days,:agreed_number_of_hours,
                :indefinite_duration,:present_during_borrowing_period,:entire_period,:partial_period,:provide_proper_use_training,:specific_conditions,:goodwill,:age_18_or_more,
                :is_active,:date_created,:date_updated,:date_deleted,:organization_name,:displayLenderOrganizationName,:approved,:notify_borrowers,:receive_borrower_notifications,
                :item_condition_id,:security_deposit_amount,:security_deposit,:is_community,:user_id,:remote_ip,:comment,:advertiser_id
  
  has_many :addresses, :dependent => :destroy
  has_many :item_images, :dependent => :destroy
  
  attr_accessible :addresses_attributes, :item_images_attributes
  accepts_nested_attributes_for :item_images
  accepts_nested_attributes_for :addresses
  
  has_many :primary_addresses, :dependent => :destroy
  attr_accessible :primary_addresses
  accepts_nested_attributes_for :primary_addresses
  
  has_many :alternative_addresses, :dependent => :destroy
  attr_accessible :alternative_addresses
  accepts_nested_attributes_for :alternative_addresses
  
   
  
  ###  Lender tables contains i_c_id, c_i, c_i
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
