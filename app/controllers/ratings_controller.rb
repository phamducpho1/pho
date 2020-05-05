class RatingsController < ApplicationController
  before_action :logged_in_user, only: :create
  def create
    @rating = Rating.find_by product_id: params[:product_id], user_id: session[:user_id]
    if @rating
      flash[:info] = t "raiting.not_ratings"
    else
      insert_rating
    end
    redirect_to product_path(params[:product_id])
  end

  private

  def insert_rating
    @create_rating = Rating.create(vote: params[:rating], product_id: params[:product_id],
        user_id: session[:user_id], comment: params[:comentario])
    if @create_rating
      flash[:success] = t "raiting.success_raiting"
    else
      flash[:info] = t "raiting.not_ratings"
    end
  end
end
