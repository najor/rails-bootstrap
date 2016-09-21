require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def test_should_get_index
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in customers(:one)

    get :index
    assert_response :success
  end
end
