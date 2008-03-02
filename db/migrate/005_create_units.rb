class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.integer :unit_num, :null => 'false'
      t.integer :width
      t.integer :height
      t.integer :monthly_price
      t.string :name
      t.string :address
      t.string :phone
      t.string :alt_phone
      t.string :auth_users
      t.string :code
      t.string :phone
      t.string :status
      t.integer :building_id, :null => 'false'




      t.timestamps
    end
  end

  def self.down
    drop_table :units
  end
end
