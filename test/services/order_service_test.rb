require 'test_helper'

class OrderServiceTest < ActiveSupport::TestCase
  def test_get_orders
    order = OrderService.get_orders_by_customer_id(
      Customer.first, 'status', 'asc'
    )
    assert_equal 3, order.size
  end

  def test_products_by_date_range
    initial_date = Date.parse('23-06-2015')
    end_date = Date.parse('30-06-2015')

    products_by_range_date = OrderService.get_products_sold_date_range(
      initial_date,
      end_date
    )

    assert_equal 2, products_by_range_date.length
    assert_equal 2, products_by_range_date[Product.find(1)]
    assert_equal nil, products_by_range_date[Product.find(2)]
    assert_equal 1, products_by_range_date[Product.find(3)]
  end

  def test_items_by_date_range
    initial_date = Date.parse('23-06-2015')
    end_date = Date.parse('30-06-2015')

    items = OrderService.get_items_sold_date_range(
      initial_date,
      end_date
    )

    assert_equal 2, items.length
    assert_equal 2, items[Item.find(1)]
  end

  def test_customer_count_by_orders
    initial_date = Date.parse('23-06-2015')
    end_date = Date.parse('30-06-2015')

    orders = OrderService.get_orders_customer_percentage(
      initial_date,
      end_date
    )

    assert_equal 2, orders.length
    assert_equal 2, orders[0]['number_of_orders']
    assert_equal 1, orders[0]['number_of_customers']
  end
end
