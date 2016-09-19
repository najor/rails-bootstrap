# Some statistics to study how well the sells go
class StatisticsController < ApplicationController
  def index
    @customers_categories = CustomerService.find_customer_category_sql
  end

  def data_range_date
    initial_date = params[:initial_date] ? Date.parse(params[:initial_date]) : Date.new
    end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.new
    products = OrderService.get_products_sold_date_range(initial_date, end_date)
    items = OrderService.get_items_sold_date_range(initial_date, end_date)
    orders_customer_count = OrderService.get_orders_customer_percentage(initial_date, end_date)

    count_orders = Order.where(:orders.created_at => initial_date.beginning_of_day..end_date.end_of_day).count
    render json: {
      products: products.map { |prod, count| { name: prod.name, count: count } },
      items: items.map { |item, count| { name: item.name, count: count } },
      orders_customers: {
        total_count: count_orders,
        orders_customers: orders_customer_count
      }
    }
  end
end
