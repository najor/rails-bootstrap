require 'test_helper'

class ProductItemTest < ActiveSupport::TestCase

  def test_product_item_new
    product_item = ProductItem.new(item: Item.first, product: Product.first)
    assert product_item.save!
  end

end
