require_relative 'base_repository'

class OrderRepository < BaseRepository

  def initialize(csv_file, meal_repository, employee_repository, customer_repository)
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    super(csv_file)
  end

  def add(order)
    order.id = @next_id
    @elements << order
    @next_id += 1
    write_csv
  end

  def undelivered_orders
    @elements.reject { |order| order.delivered? }
  end

  def undelivered_orders_for_employee(employee)
    undelivered_orders.select { |order| order.employee == employee }
  end

  def save
    write_csv
  end

  private

  def build_element(row)
    row[:id] = row[:id].to_i                          # Convert column to Fixnum
    row[:delivered] = row[:delivered] == "true"       # Convert column to Fixnum
    row[:meal] = @meal_repository.find(row[:meal_id].to_i)
    row[:employee] = @employee_repository.find(row[:employee_id].to_i)
    row[:customer] = @customer_repository.find(row[:customer_id].to_i)
    Order.new(row)
  end
end
