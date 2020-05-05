class ApplicationController < ActionController::Base
  helper_method [:recent_products, :last_viewed_product]
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  include SessionsHelper
  def current_cart
    @cart_id = Cart.find_by id: session[:cart_id]
    if @cart_id.blank?
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    else
      Cart.find_by id: session[:cart_id]
    end
  end

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t "ple_login"
    redirect_to new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(name phone address))
    devise_parameter_sanitizer.permit(:account_update, keys: %i(name phone address))
  end

  def recent_products
    @recent_products ||= RecentProducts.new cookies
  end

  def last_viewed_product
    recent_products.reverse.second
  end
end
