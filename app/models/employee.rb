class Employee

  ROLES = [
    MANAGER = "manager",
    DELIVERY_GUY = "delivery_guy"
  ]

  attr_accessor :id
  attr_reader :username, :password, :role

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @username = attributes.fetch(:username, nil)
    @password = attributes.fetch(:password, nil)
    @role = attributes.fetch(:role, DELIVERY_GUY)
  end

  def manager?
    @role == MANAGER
  end

  def delivery_guy?
    @role == DELIVERY_GUY
  end

  # not needed as we can't add employees (only manually to the csv)

  # def to_csv_row
  #   [@id, @username, @password, @role]
  # end

  # def self.headers
  #   %w(id username password role)
  # end

end
