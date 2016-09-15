require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  def test_get_index
    get :index
    assert_response :success
  end
end
