require 'test_helper'

class CustomerServiceTest < ActiveSupport::TestCase
  def test_customer_category
    assert_equal 3, CustomerService.find_customer_category_sql.size
  end

  def test_customer_category_record
    assert_equal 3, CustomerService.find_customer_category_record.length
  end

  def test_customers_new_recurring
    customers = CustomerService.customers_new_and_recurring

    assert_equal 2, customers.size
    assert_equal 2, customers['06/2015']['recurrences']
    assert_equal 1, customers['06/2015']['news']
  end
end
