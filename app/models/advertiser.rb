class Advertiser < ActiveRecord::Base
  
  set_primary_key :advertiser_id
    
  has_many :itemimages
  before_create :get_advertiser_primary_key_value
    
  name_alpha_regex = /\A[ a-zA-Z'-]+\z/
  alpha_numeric_regex = /\A[0-9 a-zA-Z:;.,!?'-]+\z/
  alpha_numeric_regex_msg = "must be alphanumeric characters with typical writing punctuation."
  alpha_numeric_regex_username = /\A[0-9 a-zA-Z\-\_]+\z/
    
  validates_uniqueness_of :advertiser_name,:if => :advertiser_name, :case_sensitive => true, :message =>  " already exists."
  validates_uniqueness_of :advertiser_email,:if => :advertiser_email, :case_sensitive => false, :message =>  " already exists"
  validates_uniqueness_of :advertiser_url,:if => :advertiser_url, :case_sensitive => false, :message =>  " already exists"
  
  
  protected

  def get_advertiser_primary_key_value
     advertiser_id = get_random unless advertiser_id.present?
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
