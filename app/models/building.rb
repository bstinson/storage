class Building < ActiveRecord::Base
  belongs_to :company
  has_many :units
end
