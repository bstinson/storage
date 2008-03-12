class Unit < ActiveRecord::Base
  belongs_to :building
  has_many :notes
  
  # Allowed sizes for data fields
  UNIT_NUM_MAX_LENGTH   = 3
  NAME_MIN_LENGTH       = 3
  NAME_MAX_LENGTH       = 25
  ADDRESS_MIN_LENGTH    = 10
  ADDRESS_MAX_LENGTH    = 40
  CITY_MIN_LENGTH       = 5
  CITY_MAX_LENGTH       = 20
  STATE_LENGTH          = 2
  ZIP_LENGTH            = 5
  SSN_LENGTH            = 9
  DL_LENGTH             = 9
  PHONE_MIN_LENGTH      = 7
  PHONE_MAX_LENGTH      = 14
  EMAIL_MAX_LENGTH      = 30
  PRICE_MAX_LENGTH      = 5
  DEPOSIT_MAX_LENGTH    = 5
  CODE_LENGTH           = 4

  # Text Box sizes for fields in form.
  MEASURED_SIZE       = 3
  UNIT_NUM_SIZE       = 5
  NAME_SIZE           = 15
  SSN_SIZE            = 15
  ADDRESS_SIZE        = 20
  CITY_SIZE           = 15
  STATE_SIZE          = 3
  ZIP_SIZE            = 5
  PHONE_SIZE          = 10
  EMAIL_SIZE          = 15
  DL_SIZE             = 10
  AUTH_USERS_SIZE     = 20
  DEPOSIT_SIZE        = 5
  PRICE_SIZE          = 5
  CODE_SIZE           = 5
    
  # Allowed Ranges
  NAME_RANGE = NAME_MIN_LENGTH..NAME_MAX_LENGTH
  ADDRESS_RANGE = ADDRESS_MIN_LENGTH..ADDRESS_MAX_LENGTH
  CITY_RANGE = CITY_MIN_LENGTH..CITY_MAX_LENGTH
  PHONE_RANGE = PHONE_MIN_LENGTH..PHONE_MAX_LENGTH
  
  # Actual Data Validations
  validates_presence_of :unit_num, :width, :height, :building_id, :company_id
  validates_uniqueness_of :unit_num, :scope => [:building_id, :unit_num], :message => "You have already added this unit to the building."
  validates_numericality_of :monthly_price, :allow_nil => true
  validates_numericality_of :deposit, :allow_nil => true  
  validates_length_of :name, :within => NAME_RANGE, :allow_nil => true
  validates_length_of :address, :within => ADDRESS_RANGE, :allow_nil => true
  validates_length_of :city, :within => CITY_RANGE, :allow_nil => true
  validates_length_of :state, :is => STATE_LENGTH, :allow_nil => true
  validates_length_of :zip, :is => ZIP_LENGTH, :allow_nil => true
# validates_length_of :ssn, :is => SSN_LENGTH, :allow_nil => true, :allow_blank => true
  validates_length_of :dl, :is => DL_LENGTH, :allow_nil => true, :allow_blank => true
  validates_length_of :phone, :within => PHONE_RANGE, :allow_nil => true
  validates_length_of :alt_contact, :within => NAME_RANGE, :allow_nil => true
  validates_length_of :alt_phone, :within => PHONE_RANGE, :allow_nil => true
end
