class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :product_id
      t.string :sku
      t.string :name
      t.decimal :price
      t.decimal :cost
      t.datetime :deleted_at
      t.boolean :master
      t.integer :inventory_id
      t.integer :image_group_id

      t.timestamps null: false
    end
  end
end
