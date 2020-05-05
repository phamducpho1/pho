class CartsController < ApplicationController
  before_action :ses_cart, only: %i(show index)

  def index; end

  def show; end

  def create; end

  def destroy
    @cart = current_cart
    if @cart.destroy
      session[:cart_id] = nil
      flash[:warning] = t "static_pages_controller.eror_nilcart"
      redirect_to root_url
    else
      flash[:warning] = t "static_pages_controller.carts"
      redirect_to cartyour_path
    end
  end

  private

  def ses_cart
    @cart = Cart.find_by(id: session[:cart_id])
    return if @cart
    flash[:warning] = t "static_pages_controller.carts"
    redirect_to root_url
  end
end
