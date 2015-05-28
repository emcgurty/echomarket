class ItemImage < ActiveRecord::Base
  
  require 'fastimage'
  attr_accessor :item_image_upload
  attr_accessible :lender_id, :borrower_id, :advertiser_id, :item_image_caption, :is_active, :date_created, :date_deleted, :item_image_upload
   
  belongs_to :advertiser
  belongs_to :borrower
  belongs_to :lender
  before_create :get_primary_key_value, :item_image_upload
  before_update :item_image_upload

  protected

  def get_primary_key_value
    if self.id.blank?
    self.id = get_random
    end
    return self.id

  end

  def item_image_upload=(picture_field)
    if picture_field.blank?
      return
    end

    stored_file_name = get_primary_key_value + "_" + picture_field.original_filename  
    directory = "#{Rails.root}/public/images/item_images/"
    path = File.join(directory, stored_file_name)
    ##delete_old_image_file(path)
    File.open(path, "wb") { |f| f.write(picture_field.read) }
    my_array          = FastImage.size(path)
    self.image_file_name = stored_file_name 
    self.image_content_type = picture_field.content_type.chomp
    self.item_image_caption = self.item_image_caption
    self.image_height =  my_array[1].to_s
    self.image_width =  my_array[0].to_s

  end

  def delete_old_image_file(new_file)
 
   directory = "#{Rails.root}/public/images/item_images/"
    unless self.lender_id.blank?
      @deleteFile = Itemimage.find(:all, :readonly, :conditions => ["lender_id = ? and item_image_id = ?", self.lender_id, self.item_image_id ])
    else
      @deleteFile = Itemimage.find(:all, :readonly, :conditions => ["borrower_id = ? and item_image_id = ?", self.borrower_id, self.item_image_id ])
    end
    unless @deleteFile.blank?
      @deleteFile.each do |dlf|
        path = File.join(directory, dlf.image_file_name)
        if (new_file != path)
          File.delete(path) if File.exist?(path)
        end
      end
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
