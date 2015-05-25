class Advertiser < ActiveRecord::Base

  require 'uri'

  attr_accessor :item_image_upload
  has_one :item_image, dependent: :destroy
  has_one :category

  accepts_nested_attributes_for :item_image
  before_create :get_advertiser_primary_key_value
  before_create :save_image
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

  def save_image
    ItemImage.create(:item_image_upload => self.item_image_upload, :advertiser_id => self.id)
  end

  def get_advertiser_primary_key_value
    self.id = get_random
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
