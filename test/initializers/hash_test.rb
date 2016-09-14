require 'test_helper'

class HashTest < ActiveSupport::TestCase

  def setup
    @hash_level = {value: '0', one: {value: '1', two: {value: '2', three: {value: '3'}}}}
  end

  def test_hash_zero_level
    assert_equal '0', @hash_level.dig(:value)
  end

  def test_hash_first_level
    assert_equal '1', @hash_level.dig(:one, :value)
  end

  def test_hash_second_level
    assert_equal '2', @hash_level.dig(:one, :two, :value)
  end

  def test_hash_third_level
    assert_equal '3', @hash_level.dig(:one, :two, :three, :value)
  end

  def test_not_exists_attribute
    assert_equal nil, @hash_level.dig(:one, :no_exist, :three, :value)
  end

end