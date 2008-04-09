class ChangeRentalDataType < ActiveRecord::Migration
  def self.up
    change_column :units, :monthly_price, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    change_column :units, :monthly_price, :integer
  end
end
