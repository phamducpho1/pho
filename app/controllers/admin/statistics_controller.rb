class Admin::StatisticsController < ApplicationController
  def index
     @user_support = Supports::UserSupport.new
     if params[:filter_order]
       @filter_orders = Order.created_in_time params[:date_from].to_date,
         params[:date_to].to_date
     end
  end
end
