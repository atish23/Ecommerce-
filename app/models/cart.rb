class Cart < ActiveRecord::Base
	belongs_to :user
	#belongs_to :customer, :class_name 'User'
  has_many    :cart_items
  has_many    :shopping_cart_items, -> { where(active: true, item_type_id: ItemType::SHOPPING_CART_ID) },   class_name: 'CartItem'
  has_many    :saved_cart_items,    -> { where( active: true, item_type_id: ItemType::SAVE_FOR_LATER_ID) }, class_name: 'CartItem'
end
