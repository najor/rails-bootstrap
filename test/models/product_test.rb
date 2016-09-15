require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def test_categories_load
    assert_equal 2, Category.all.size
  end

  def test_product_new
    product = Product.new(name: 'Product', category: Category.first)
    assert product.save
  end
end
