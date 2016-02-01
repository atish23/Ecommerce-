class AddFieldToImage < ActiveRecord::Migration
  def change
    add_column :images, :image_width, :integer
  end
end
