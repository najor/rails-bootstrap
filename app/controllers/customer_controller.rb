class CustomerController < ApplicationController

  def index
    @customers_categories = CustomerService.get_customer_category_sql
  end

end
