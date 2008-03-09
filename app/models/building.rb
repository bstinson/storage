class Building < ActiveRecord::Base
  belongs_to :company
  has_many :units
  
# Sizes for data fields
COMPANY_NAME_MIN = 3
COMPANY_NAME_MAX = 20

# Ranges for data fields
COMPANY_NAME_RANGE = COMPANY_NAME_MIN..COMPANY_NAME_MAX

# Validations  
  validates_presence_of   :name, :company_id
  validates_uniqueness_of :name
  validates_length_of     :name, :within => COMPANY_NAME_RANGE
end
