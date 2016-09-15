# Customer controller for customer data
class CustomerController < ApplicationController
  def index
    @customers_categories = CustomerService.find_customer_category_sql
  end
end
