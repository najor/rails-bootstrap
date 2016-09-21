require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def test_get_index
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in customers(:one)

    get :index
    assert_response :success
  end

  def test_data_range_date
    get :data_range_date, initial_date: '23-06-2015', end_date: '30-06-2015'

    data = JSON.parse(@response.body)

    assert_equal 2, data['products'].size
    assert_equal 2, data['items'].size
    assert_equal 2, data['orders_customers']['orders_customers'].size
  end
end
