class Note < ActiveRecord::Base
  belongs_to :unit
  belongs_to :user
  belongs_to :prevcustomer
end
