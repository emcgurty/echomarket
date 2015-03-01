class Borrowers < ActiveRecord::Base

  set_primary_key :borrower_item_id
  has_many :itemimages
  before_create :get_borrower_primary_key_value

  protected

  def get_borrower_primary_key_value
    return if not (self.borrower_item_id.blank?)
    self.borrower_item_id = get_random
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
