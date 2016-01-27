class CreateProductProperties < ActiveRecord::Migration
  def change
    create_table :product_properties do |t|
      t.integer :product_id
      t.integer :property_id
      t.integer :position
      t.string :description

      t.timestamps null: false
    end
  end
end
