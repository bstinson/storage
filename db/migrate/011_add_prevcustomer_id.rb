class AddPrevcustomerId < ActiveRecord::Migration
  def self.up
    add_column    :notes, :prevcustomer_id, :integer
    change_column :notes, :unit_id, :integer, :null => 'true'
  end

  def self.down
    remove_column :notes, :prevcustomer_id
    change_column :notes, :unit_id, :integer, :null => 'false'
  end
end
