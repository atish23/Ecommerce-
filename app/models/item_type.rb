class ItemType < ActiveRecord::Base

	 has_many :cart_items
	 
	 SHOPPING_CART   = 'shopping_cart'
	 SAVE_FOR_LATER  = 'save_for_later'

	 SHOPPING_CART_ID   = 1
	 SAVE_FOR_LATER_ID  = 2
end
