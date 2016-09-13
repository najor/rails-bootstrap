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
      flash[:error] = customer ? I18n.t('login_password_incorret') : I18n.t('login_user_not_found')
      redirect_to '/'
    end
  end

end
