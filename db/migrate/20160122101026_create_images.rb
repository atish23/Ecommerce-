class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.integer :image_height
      t.integer :position
      t.string :caption

      t.timestamps null: false
    end
  end
end
