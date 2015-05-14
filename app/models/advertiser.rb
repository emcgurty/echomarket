class Advertiser < ActiveRecord::Base
  # attr_accessible :title, :body
  
    # attr_accessible :title, :body
  set_primary_key :advertiser_id
  has_many :itemimages
  before_create :get_advertiser_primary_key_value
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  name_alpha_regex = /\A[ a-zA-Z'-]+\z/
  alpha_numeric_regex = /\A[0-9 a-zA-Z:;.,!?'-]+\z/
  alpha_numeric_regex_msg = "must be alphanumeric characters with typical writing punctuation."
  alpha_numeric_regex_username = /\A[0-9 a-zA-Z\-\_]+\z/
    
  validates_uniqueness_of :advertiser_name,:if => :advertiser_name, :case_sensitive => true, :message =>  " already exists."
  validates_uniqueness_of :advertiser_email,:if => :advertiser_email, :case_sensitive => false, :message =>  " already exists"
  validates :advertiser_email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  
  protected

  def get_advertiser_primary_key_value
     self.advertiser_id = get_random
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
