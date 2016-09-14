class OrderService

  def self.get_orders_by_customer_id(customer_id, sort_column, sort_direction)
    Order
      .where(customer_id: customer_id)
      .order("#{sort_column} #{sort_direction}")
  end

end