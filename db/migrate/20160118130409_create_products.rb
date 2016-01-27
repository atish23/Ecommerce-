class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.text :product_keywords
      t.integer :product_type_id
      t.integer :prototype_id
      t.datetime :available_at
      t.datetime :deleted_at
      t.boolean :featured
      t.boolean :active
      t.integer :brand_id

      t.timestamps null: false
    end
  end
end
