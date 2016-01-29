class ProductsController < ApplicationController
  def index
  	products = Product.active.includes(:variants)
  	# form_info
    # binding.pry
  	product_types = nil
  	if params[:product_type_id].present? && product_type = ProductType.find_by_id(params[:product_type_id])
  		product_types = product_type.self_and_descendants.map(&:id)
  	end
  	if product_types
  		@products = products.where(product_type_id: product_types)
  	else
  		@products = products
  	end

  end

  def show
  	@products = Product.all
    @product = Product.find(params[:id])
    @cart_action = @product.cart_action current_user.try :id
    #raise @cart_action.inspect
    # form_info
  end

  def create

  end

  # def form_info
  #   @cart_item = CartItem.new
  # end

end
