class Contacts < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  set_primary_key :contact_id
  validates :email, :format => { :with => email_regex, :message => "Expecting format valid_email_username@valid_email_server_name.valid_email_server_type"}
  validates :subject,  :presence => {:message => "is a required field."}
  validates :comments,  :presence => {:message => "is a required field."}
end