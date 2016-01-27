class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :abbreviation
      t.string :described_as
      t.boolean :active
      t.integer :shipping_zone_id

      t.timestamps null: false
    end
  end
end
