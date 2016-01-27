class WelcomeController < ApplicationController
  def index
  	  	@featured_products = Product.featured
  	  	@products = Product.all
  end
end
