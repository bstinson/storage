class User < ActiveRecord::Base
  
  belongs_to :company
  has_many :notes  
  # Creates a temporary variable that can be used when changing a user's password.
  attr_accessor :current_password
  
  # Validates that the confirmation field is identical to the new password field (Used for verification purposes.)
  validates_confirmation_of :password
  
  # Clear the password (usually to keep it from showing up in a view.)
  def clear_password!
    self.password = nil
    self.password_confirmation = nil
    self.current_password = nil
  end

  
  # Maximum and Minimum Lengths for all fields
  NAME_MIN_LENGTH = 3
  NAME_MAX_LENGTH = 20
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 20
  EMAIL_MAX_LENGTH = 50
  NAME_RANGE = NAME_MIN_LENGTH..NAME_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
  
  #Text Box sizes for display in the views
  NAME_SIZE = 20
  PASSWORD_SIZE = 10
  EMAIL_SIZE = 30
  
  validates_uniqueness_of :name, :email
  validates_length_of :name, :within => NAME_RANGE
  validates_length_of :password, :within => PASSWORD_RANGE
  validates_length_of :email, :maximum => EMAIL_MAX_LENGTH
  
  validates_format_of :name,
                      :with => /^[A-Z0-9_]*$/i,
                      :message => "must contain only letters, " +
                                  "numbers, and underscores"
                                  
  validates_format_of :email,
                      :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                      :messsage => "must be a valid email address"
end