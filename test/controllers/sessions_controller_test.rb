require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def test_should_get_login
    get :login
    assert_response :success
  end

  def test_login_attempt_no_params
    post :login_attempt
    assert_redirected_to action: 'login'
    assert_equal I18n.t('login_user_not_found'), flash[:error]
  end

  def test_logout
    get :logout
    assert_redirected_to '/'
    assert_equal I18n.t('logout_successful'), flash[:message]
  end

  def test_login_attempt_params
    post :login_attempt, email: 'joseph@gmail.com', pass: '987654321'
    assert_redirected_to controller: 'home'
  end
end
