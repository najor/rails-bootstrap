# OrderService
class OrderService
  def self.get_orders_by_customer_id(customer_id, sort_column, sort_direction)
    Order
      .where(customer_id: customer_id)
      .order("#{sort_column} #{sort_direction}")
  end

  def self.get_products_sold_date_range(initial_date, end_date)
    Order
      .joins('LEFT JOIN products ON orders.product_id = products.id')
      .where(created_at: initial_date.beginning_of_day..end_date.end_of_day)
      .group(:product)
      .size
  end
end
