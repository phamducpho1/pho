class HistoriesController < ApplicationController
  def show
    @order_details = OrderDetail.find_order params[:id]
    return if @order_details
    flash[:error] = t "user.show.notfind"
    redirect_to root_url
  end
end
