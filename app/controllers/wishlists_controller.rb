class WishlistsController < ApplicationController

# def new
# 	@wishlist = Wishlist.new
# end
def index
	@wishlist_products = Wishlist.where(:user_id => current_user.id)
end

def create

	@wishlist = Wishlist.new
	product_id = params[:product_id]
	if @wishlist.wishlist_item_present(current_user.id , product_id).present?
		redirect_to :back , :notice => "Wishlist already present"
	else
		@wishlist.update_attributes(:user_id => current_user.id , :product_id => params[:product_id])
		redirect_to root_path ,  :notice => "Wishlist created"

	end
end

def destroy
	
end

end
