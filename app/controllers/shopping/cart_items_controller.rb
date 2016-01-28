class Shopping::CartItemsController < ApplicationController
	 
	def index
    @cart_items = session_cart.shopping_cart_items
    @saved_cart_items = session_cart.saved_cart_items
  end

  def create
    session_cart.save if session_cart.new_record?
    qty = params[:cart_item][:quantity].to_i
    if cart_item = session_cart.add_variant(params[:cart_item][:variant_id], most_likely_user, qty)
      flash[:notice] = [I18n.t('out_of_stock_notice'), I18n.t('item_saved_for_later')].compact.join(' ') unless cart_item.shopping_cart_item?
      session_cart.save_user(most_likely_user)
      redirect_to(shopping_cart_items_url)
    else
      variant = Variant.includes(:product).find_by_id(params[:cart_item][:variant_id])
      if variant
        redirect_to(product_url(variant.product))
      else
        flash[:notice] = I18n.t('something_went_wrong')
        redirect_to(root_url())
      end
    end
  end

end
