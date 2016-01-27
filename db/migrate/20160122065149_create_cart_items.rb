class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :user_id
      t.integer :cart_id
      t.integer :variant_id
      t.integer :quantity
      t.boolean :active
      t.integer :item_type_id

      t.timestamps null: false
    end
  end
end
