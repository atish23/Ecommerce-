class AddFieldsToImages < ActiveRecord::Migration
  def change
    add_column :images, :demo, :string
  end
end
