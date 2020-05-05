class StaticPagesController < ApplicationController
  def index
    @products = Product.search_by_name(params[:search]).search_price(load_params)
      .sort_by_product.paginate(page: params[:page], per_page: Settings.per_page.config)
    @categories = Category.sort_by_category
    @runouts = Product.product_hot
  end

  def show
    @categories = Category.sort_by_category
    @current_category = Category.find_by id: params[:id]
    if @current_category
      @products = @current_category.products.paginate(page: params[:page], per_page: Settings.per_page.config)
    else
      flash[:warning] = t "static_pages_controller.errors"
      redirect_to root_url
    end
  end

  def help; end

  private

  def load_params
    if params[:reson].present?
      return if params[:reson][:price] == Settings.controllers.products.all
      start, last = params[:reson][:price].split(Settings.controllers.products.to)
      start..last
    end
  end
end
