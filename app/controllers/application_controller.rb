class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def session_cart
    return @session_cart if defined?(@session_cart)
    session_cart!
  end
  # use this method if you want to force a SQL query to get the cart.
  def session_cart!
    if cookies[:cart_id]
      @session_cart = Cart.includes(:shopping_cart_items).find_by_id(cookies[:cart_id])
      unless @session_cart
        @session_cart = Cart.create(:user_id => current_user)
        cookies[:cart_id] = @session_cart.id
      end
    elsif current_user && current_user.current_cart
      @session_cart = current_user.current_cart
      cookies[:cart_id] = @session_cart.id
    else
      @session_cart = Cart.create
      cookies[:cart_id] = @session_cart.id
    end
    @session_cart
  end

  # def current_user_session
  #   return @current_user_session if defined?(@current_user_session)
  #   @current_user_session = UserSession.find
  # end

  # def current_user
  #   return @current_user if defined?(@current_user)
  #   @current_user = current_user_session && current_user_session.record
  # end

  # def current_user_id
  #   return @current_user_id if defined?(@current_user_id)
  #   @current_user_id = current_user_session && current_user_session.record && current_user_session.record.id
  # end
    rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

end
