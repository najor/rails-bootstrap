# OrderService
class OrderService
  def self.get_orders_by_customer_id(customer_id, sort_column, sort_direction)
    Order
      .where(customer_id: customer_id)
      .order("#{sort_column} #{sort_direction}")
  end

  def self.get_products_sold_date_range(initial_date, end_date)
    Order
      .joins('INNER JOIN products ON orders.product_id = products.id')
      .where(created_at: initial_date.beginning_of_day..end_date.end_of_day)
      .group(:product)
      .size
  end

  def self.get_items_sold_date_range(initial_date, end_date)
    ProductItem
      .joins('JOIN orders ON product_items.product_id = orders.product_id')
      .where('orders.created_at' => initial_date.beginning_of_day..end_date.end_of_day)
      .group(:item)
      .size
  end

  def self.get_orders_customer_percentage(initial_date, end_date)
    ActiveRecord::Base.connection.execute(
      'select number_of_orders, count(*) as number_of_customers from (' \
      'select count(*) as number_of_orders, orders.customer_id as cust_id ' \
      'from orders ' \
      "where orders.created_at between '#{initial_date}' and '#{end_date}' " \
      'group by orders.customer_id' \
      ') group by cust_id '
    )
  end
end
