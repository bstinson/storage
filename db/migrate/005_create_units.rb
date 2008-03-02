class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.integer :unit_num, :null => 'false'
      t.integer :width
      t.integer :height
      t.integer :monthly_price
      t.string :name
      t.string :ssn
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email
      t.string :work_cell
      t.string :alt_contact
      t.string :alt_phone
      t.string :auth_users
      t.string :code
      t.string :status
      t.integer :building_id, :null => 'false'




      t.timestamps
    end
  end

  def self.down
    drop_table :units
  end
end
