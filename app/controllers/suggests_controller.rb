class SuggestsController < ApplicationController
  before_action :load_suggest, only: %i(edit destroy show)

  def index; end

  def show; end

  def new
    @suggest = current_user.suggests.build
  end

  def create
    @suggest = current_user.suggests.new suggest_params
    if @suggest.save
      flash[:success] = t "admin.create"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def suggest_params
    params.require(:suggest).permit(:content)
  end

  def load_suggest
    @suggest = Suggest.find_by id: params[:id]
    return if @suggest
    flash[:warning] = t "users_controller.errorss"
    redirect_to admin_products_path
  end
end
