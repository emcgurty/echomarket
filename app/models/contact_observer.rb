class ContactObserver < ActiveRecord::Observer
  
  observe :contact

  def before_create(contacts)
    contacts.contact_id = get_random
    
  end

  def get_random
    length = 36
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    @password = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @password
  end


end
