require 'digest/sha1'

class Communities < ActiveRecord::Base

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  name_alpha_regex = /\A[ a-zA-Z'-]+\z/
  alpha_numeric_regex = /\A[0-9 a-zA-Z:;.,!?'-]+\z/
  alpha_numeric_regex_msg = "must be alphanumeric characters with typical writing punctuation."
  alpha_numeric_regex_community_name = /\A[0-9 a-zA-Z\-\_]+\z/
  
  set_primary_key :community_id
  attr_accessor :password, :password_confirmation
  attr_accessible :password, :password_confirmation
  attr_accessible :community_name, :remote_ip, :crypted_password, :salt , :reset_code, :approved, :user_type
  attr_accessible :first_name, :mi , :last_name, :address_line_1, :address_line_2,:postal_code  ,:city, :province, :state_id, :country_id
  attr_accessible :home_phone,:cell_phone, :email, :goodwill, :age_18_or_more, :is_active ,:is_saved  
  before_save :encrypt_password
  before_create :make_activation_code
  validates  :community_name, :password, :password_confirmation, :email, :presence => true
  
  validates_uniqueness_of :community_name,:if => :community_name, :case_sensitive => true, :message =>  " already exists."
  validates_uniqueness_of :email,:if => :email, :case_sensitive => false, :message =>  " already exists"
  validates_length_of :password, :if => :password, :in => 8..16, :message => "must be between 8 and 16 characters"
  validates_confirmation_of :password ,:if => :password, :message => "and re-entered password must match."
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
    

  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    if save(:validate => false)
      return true
    else 
      return false
    end
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their community_name and unencrypted password. Returns the user or nil.
  def self.authenticate(community_name, password)
    u = find :first, :conditions => ['community_name = ? and activated_at IS NOT NULL', community_name]
    # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at
  end

  # These create and unset the fields required for remembering user between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token = encrypt("#{email}--#{remember_token_expires_at}")
    save(:validate => false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token = nil
    save(:validate => false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    return @activated
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token = nil
    save(:validate => false)
  end

  #reset methods
  def create_reset_code(which)
    @reset = true
    self.attributes = {:reset_code => Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )}
    if which == 'password'
      @reset_password = true
    else
      @get_community_name = true
    end
    save(:validate => false)
  end

  def recently_reset?
    @reset
  end

  def recently_password_reset?
    @reset_password
  end

  def recently_community_name_get?
    @get_community_name
  end
  
  def delete_reset_code
    self.attributes = {:reset_code => nil}
    save(:validate => false)
  end

  protected
  # before filter
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{community_name}--") if new_record?
    self.crypted_password = encrypt(password)
  end

  def password_required?
    crypted_password.blank? || !password.blank?
  end

  def make_activation_code
    self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

end