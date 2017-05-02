class Customer

  attr_accessor :id
  attr_reader :name, :address

  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @name = attributes.fetch(:name, nil)
    @address = attributes.fetch(:address, nil)
  end

  def to_csv_row
    [@id, @name, @address]
  end

  def self.headers
    %w(id name address)
  end
end
