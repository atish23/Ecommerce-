class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name
      t.integer :parent_id
      t.boolean :active
      t.integer :rgt
      t.integer :lft

      t.timestamps null: false
    end
  end
end
