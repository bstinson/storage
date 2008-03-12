class AddDeposit < ActiveRecord::Migration
  def self.up
    add_column :units, :deposit, :integer, :default => "0"
  end

  def self.down
    remove_column :units, :deposit, :integer  
  end
end
