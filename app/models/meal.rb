class Meal

  attr_accessor :id
  attr_reader :name, :price

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @name = attributes.fetch(:name, nil)
    @price = attributes.fetch(:price, nil)
  end

  def to_csv_row
    [@id, @name, @price]
  end

  def self.headers
    %w(id name price)
  end
end
