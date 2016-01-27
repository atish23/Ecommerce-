class AddPaperclipToImage < ActiveRecord::Migration
  def change
  	add_attachment :images, :photo  
  end
end
