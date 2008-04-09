class ChangeDepositDataType < ActiveRecord::Migration
  def self.up
    change_column :units, :deposit, :decimal, :precision => 8, :scale => 2
    
  end

  def self.down
    change_column :units, :monthly_price, :integer
  end
end
