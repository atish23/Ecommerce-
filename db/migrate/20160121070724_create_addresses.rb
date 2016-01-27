class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :city
      t.integer :state_id
      t.integer :country_id
      t.string :zip_code
      t.boolean :default
      t.boolean :active
      t.string :state_name

      t.timestamps null: false
    end
  end
end
