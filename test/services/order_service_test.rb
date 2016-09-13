require 'test_helper'

class OrderServiceTest < ActiveSupport::TestCase

  def test_get_orders
    assert_equal 3, OrderService.get_orders_by_customer_id(Customer.first, 'status', 'asc').size
  end

end