# Session controller manages the login and logout or customers
class SessionsController < ApplicationController
  def login
    redirect_to controller: 'home' if session[:user_id]
  end

  def logout
    session[:user_id] = nil
    flash[:message] = I18n.t('logout_successful')
    redirect_to '/'
  end

  def login_attempt
    customer = Customer.find_by_email(params[:email])
    if customer && customer.authenticate(params[:pass])
      session[:user_id] = customer.id
      redirect_to controller: 'home'
    else
      message = customer ? 'login_password_incorrect' : 'login_user_not_found'
      flash[:error] = I18n.t(message)
      redirect_to '/'
    end
  end
end
