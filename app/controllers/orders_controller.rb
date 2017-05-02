require_relative "../models/order.rb"
require_relative "../views/orders_view.rb"

class OrdersController
  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @order_repository = order_repository
    @view = OrdersView.new
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @view.display(orders)
  end

  def add
    meal = ask_user_for_meal
    customer = ask_user_for_customer
    employee = ask_user_for_employee

    new_order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.add(new_order)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders_for_employee(employee)
    @view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.undelivered_orders_for_employee(employee)
    @view.display(orders)
    order_id = @view.ask_for_integer(:order)
    order = orders.find { |o| order_id == o.id }
    order.deliver!
    @order_repository.save
  end

  private

  def ask_user_for_meal
    MealsController.new(@meal_repository).list
    meal_id = @view.ask_for_integer(:meal)
    @meal_repository.find(meal_id)
  end

  def ask_user_for_customer
    CustomersController.new(@customer_repository).list
    customer_id = @view.ask_for_integer(:customer)
    @customer_repository.find(customer_id)
  end

  def ask_user_for_employee
    delivery_guys = @employee_repository.all_delivery_guys
    @view.display_delivery_guys(delivery_guys)
    employee_id = @view.ask_for_integer(:employee)
    @employee_repository.find(employee_id)
  end
end
