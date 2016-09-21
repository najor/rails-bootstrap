# Customer Service
class CustomerService
  def self.find_customer_category_sql
    ActiveRecord::Base.connection.execute(
      'select c.id as customer_id, c.first_name, ' \
      'cat.id as category_id, cat.name as category_name ' \
      'from orders o, customers c, products p, categories cat ' \
      'where o.customer_id = c.id ' \
      'and o.product_id = p.id ' \
      'and p.category_id = cat.id ' \
      'group by c.id, cat.id'
    )
  end

  def self.find_customer_category_record
    Order
      .all
      .joins('JOIN customers ON customers.id = orders.customer_id')
      .joins('JOIN products ON products.id = orders.product_id')
      .joins('JOIN categories ON categories.id = products.category_id')
      .select('customers.id as customer_id,' \
                 'customers.first_name as first_name, ' \
                 'categories.id as category_id, ' \
                 'categories.name as category_name')
      .group('categories.id, customers.id')
      .order('customers.id')
  end

  def self.customers_new_and_recurring
    total = {}

    recurring_customers.each do |item|
      item['news'] = 0
      total["#{item['month']}/#{item['year']}"] = item
    end

    new_customers.each do |item|
      if total["#{item['month']}/#{item['year']}"].nil?
        item['recurrences'] = 0
        total["#{item['month']}/#{item['year']}"] = item
      else
        total["#{item['month']}/#{item['year']}"]['news'] += item['news']
      end
    end

    total
  end

  def self.new_customers
    ActiveRecord::Base.connection.execute(
      'select strftime("%m", customers.created_at) as month, ' \
      'strftime("%Y", customers.created_at) as year, count(*) as news ' \
      'from customers ' \
      'group by month, year'
    )
  end

  def self.recurring_customers
    ActiveRecord::Base.connection.execute(
      'select month, year, count(*) as recurrences from (select strftime("%m", orders.created_at) as month, ' \
      'strftime("%Y", orders.created_at) as year, count(*) as number_of_orders ' \
      'from orders ' \
      'group by month, year, customer_id) group by month, year'
    )
  end
end
