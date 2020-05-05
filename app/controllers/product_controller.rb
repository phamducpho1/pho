class ProductController < ApplicationController
  before_action :load_data, only: :show

  def show
    if @product
      @related_products = Product.not_original(params[:id]).sort_by_product.take(Settings.related_product.config)
      @new_products = Product.sort_by_product.take(Settings.new_product.config)
      # recent_products.push @product
      # @recent_products
    else
      flash[:warning] = t "static_pages_controller.errors"
      redirect_to root_url
    end
  end

  private

  def load_data
    @product = Product.find_by id: params[:id]
    @ratings = Rating.show_ratings(params[:id]).order_vote
    @avg_rating = Product.sum_product @product
    @comments = Rating.show_comment(params[:id]).order_created
      .paginate(page: params[:page], per_page: Settings.comment.config)
  end
end


