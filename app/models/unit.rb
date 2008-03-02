class Unit < ActiveRecord::Base
  belongs_to :building
  has_many :notes
  
end
