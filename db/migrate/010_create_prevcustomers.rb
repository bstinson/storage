class CreatePrevcustomers < ActiveRecord::Migration
  def self.up
    create_table :prevcustomers do |t|
      t.string :name
      t.string :ssn
      t.string :dl
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
      t.timestamps
    end
  end

  def self.down
    drop_table :prevcustomers
  end
end
