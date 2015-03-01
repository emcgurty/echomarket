class Itemimages < ActiveRecord::Base

  belongs_to :lenders
  belongs_to :borrowers

  require 'fastimage'
  set_primary_key :item_image_id

  #  set up table associations.
  attr_accessor :item_image_upload
  before_create :get_primary_key_value, :item_image_upload
  before_update :item_image_upload

  protected

  def get_primary_key_value
    return self.item_image_id if not (self.item_image_id.blank?)
    self.item_image_id = get_random
    return self.item_image_id

  end

  def item_image_upload=(picture_field)

    if picture_field.blank?
      return
    end
    directory = "public/images/item_images"
    stored_file_name = get_primary_key_value + "_" + picture_field.original_filename
    path = File.join(directory, stored_file_name)
    delete_old_image_file(path)
    File.open(path, "wb") { |f| f.write(picture_field.read) }
    my_array          = FastImage.size(path)
    self.image_file_name = stored_file_name 
    self.image_content_type = picture_field.content_type.chomp
    self.item_image_caption = self.item_image_caption
    self.image_height =  my_array[1].to_s
    self.image_width =  my_array[0].to_s

  end

  def delete_old_image_file(new_file)
 
    #  This isn't working to delete previous files, but the general update of file is working
    directory = "public/images/item_images"
    unless self.lender_item_id.blank?
      @deleteFile = Itemimages.find(:all, :readonly, :conditions => ["lender_item_id = ? and item_image_id = ?", self.lender_item_id, self.item_image_id ])
    else
      @deleteFile = Itemimages.find(:all, :readonly, :conditions => ["borrower_item_id = ? and item_image_id = ?", self.borrower_item_id, self.item_image_id ])
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
    length = 36
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    @id = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @id
  end

end
