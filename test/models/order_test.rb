require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def test_order_new
    order = Order.new(
      status: 'draft', customer: Customer.first, product: Product.first
    )
    assert order.save!
  end
end
