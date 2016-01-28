class CartItem < ActiveRecord::Base
  belongs_to :item_type
  belongs_to :user
  belongs_to :cart

	def shopping_cart_item?
    item_type_id == ItemType::SHOPPING_CART_ID && active?
  end

end
