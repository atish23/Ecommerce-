class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :identifying_name
      t.string :display_name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
