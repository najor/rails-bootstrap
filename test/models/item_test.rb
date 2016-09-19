require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def test_item_new
    item = Item.new(name: 'Item 1')
    assert item.save
    assert_equal 4, Item.all.size
  end

  def test_item_read_all
    assert_equal 3, Item.all.size
  end
end
