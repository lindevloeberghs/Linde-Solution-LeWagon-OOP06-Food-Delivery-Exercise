require_relative 'app/repositories/meal_repository'
require_relative 'app/repositories/customer_repository'
require_relative 'app/repositories/employee_repository'
require_relative 'app/repositories/order_repository'

require_relative 'app/controllers/meals_controller'
require_relative 'app/controllers/customers_controller'
require_relative 'app/controllers/sessions_controller'
require_relative 'app/controllers/orders_controller'

require_relative 'router'

meals_csv_file = File.join(__dir__, 'data/meals.csv')
customers_csv_file = File.join(__dir__, 'data/customers.csv')
employee_csv_file = File.join(__dir__, 'data/employees.csv')
order_csv_file = File.join(__dir__, 'data/orders.csv')

meal_repository = MealRepository.new(meals_csv_file)
customer_repository = CustomerRepository.new(customers_csv_file)
employee_repository = EmployeeRepository.new(employee_csv_file)
order_repository = OrderRepository.new(order_csv_file, meal_repository, employee_repository, customer_repository)

meals_controller = MealsController.new(meal_repository)
customers_controller = CustomersController.new(customer_repository)
orders_controller = OrdersController.new(meal_repository, employee_repository, customer_repository, order_repository)

sessions_controller = SessionsController.new(employee_repository)

router = Router.new(sessions_controller, meals_controller, customers_controller, orders_controller)

router.run
