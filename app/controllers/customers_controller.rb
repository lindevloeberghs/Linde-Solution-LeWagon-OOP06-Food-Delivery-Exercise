require_relative "../models/customer.rb"
require_relative "../views/customers_view.rb"

class CustomersController

  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomersView.new
  end

  def list
    display_customers
  end

  def add
    name = @view.ask_for(:name)
    address = @view.ask_for(:address)
    new_customer = Customer.new(name: name, address: address)
    @customer_repository.add(new_customer)
    display_customers
  end

  private

  def display_customers
    customers = @customer_repository.all
    @view.display(customers)
  end

end
