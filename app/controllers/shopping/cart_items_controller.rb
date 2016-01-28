class Shopping::CartItemsController < ApplicationController
	 
	 def index
	 	binding.pry
    @cart_items       = session_cart.shopping_cart_items
    # @saved_cart_items = session_cart.saved_cart_items
  end

end
