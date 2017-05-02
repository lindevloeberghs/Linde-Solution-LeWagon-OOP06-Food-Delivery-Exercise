class Order

  attr_accessor :id
  attr_reader :meal, :employee, :customer

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @customer = attributes.fetch(:customer, nil)
    @meal = attributes.fetch(:meal, nil)
    @employee = attributes.fetch(:employee, nil)
    @delivered = attributes.fetch(:delivered, false)
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end

  def to_csv_row
    [@id, @delivered, @meal.id, @employee.id, @customer.id]
  end

  def self.headers
    %w(id delivered meal_id employee_id customer_id)
  end

end
