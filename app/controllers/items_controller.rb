class ItemsController < ApplicationController
  before_action :load_product, only: [:create]
  def create
    @cart = current_cart
    @line_item = @cart.add_product @product.id
    if @line_item.save
      respond_to do |format|
        format.html{redirect_to @line_item.cart}
        format.json{head :no_content}
      end
    else
      flash[:success] = t "static_pages_controller.error_item"
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:warning] = t "static_pages_controller.error_product"
    redirect_to root_url
  end
end
