# Home: main page for the customer
class HomeController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @orders = OrderService.get_orders_by_customer_id(
      session[:user_id], sort_column, sort_direction
    )
  end

  private

  def sort_column
    sort = Order.column_names.include? params[:sort]
    sort ? params[:sort] : 'updated_at'
  end

  def sort_direction
    direction = %w([asc desc]).include? params[:direction]
    direction ? params[:direction] : 'desc'
  end
end
