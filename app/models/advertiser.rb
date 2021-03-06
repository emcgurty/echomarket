class Advertiser < ActiveRecord::Base

  require 'uri'
  
  attr_accessible :title, :description, :advertiser_email, :advertiser_url, :category_id, :category_other, :is_active, :is_activated, :date_created, :approved, :remote_ip
                  
  has_many :item_image, :dependent => :destroy
  has_many :category
  accepts_nested_attributes_for :item_image
  attr_accessible :item_image_attributes
  before_create :get_primary_key_value
  before_create :url_valid


  validates_uniqueness_of :title,:if => :title, :case_sensitive => true, :message =>  " already exists."
  validates_uniqueness_of :advertiser_email,:if => :advertiser_email, :case_sensitive => false, :message =>  " already exists"
  validates_uniqueness_of :advertiser_url,:if => :advertiser_url, :case_sensitive => false, :message =>  " already exists"

  protected

  def url_valid
    uri = URI.parse(self.advertiser_url)
    if uri.kind_of?(URI::HTTP)
    return true
    else
      self.errors.add(:advertiser_url, ": URL Link improperly formatted: http://")
    return false
    end

  end
  
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
