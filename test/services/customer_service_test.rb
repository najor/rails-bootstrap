require 'test_helper'

class CustomerServiceTest < ActiveSupport::TestCase
  def test_customer_category
    assert_equal 3, CustomerService.find_customer_category_sql.size
  end

  def test_customer_category_record
    assert_equal 3, CustomerService.find_customer_category_record.length
  end
end
