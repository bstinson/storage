class Company < ActiveRecord::Base
  has_many :users
  has_many :buildings
  
# Validations
validates_uniqueness_of :name
validates_presence_of   :name

end
