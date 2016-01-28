class ProductsController < ApplicationController
  def index
  	products = Product.active.includes(:variants)
  	#binding.pry
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
  	@product = Product.active.find(params[:id])
  end

  def create

  end

end
