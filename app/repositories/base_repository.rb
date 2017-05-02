require "csv"

class BaseRepository

  def initialize(csv_file)
    @csv_file = csv_file
    @elements = []
    @next_id = 1
    load_elements if File.exist?(@csv_file)
  end

  def add(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    write_csv # or add_element_to_csv(element)
  end

  def all
    @elements
  end

  def find(element_id)
    @elements.find { |element| element.id == element_id }
    # @elements[element_id - 1]
  end

  private

  def load_elements
    csv_options = { headers: :first_row, header_converters: :symbol, col_sep: ',', encoding: "UTF-8" }
    CSV.foreach(@csv_file, csv_options) do |row|
      @elements << build_element(row) # deserialization
      @next_id += 1
    end
  end

  def write_csv
    return if @elements.empty?
    CSV.open(@csv_file, "w") do |csv|
      csv << @elements.first.class.headers
      @elements.each do |element|
        csv << element.to_csv_row # serialization
      end
    end
  end

  # def add_element_to_csv(element)
  #   CSV.open(@csv_file, 'a+', CSV_OPTIONS) do |csv_file|
  #     csv_file << element.to_csv_row # serialization
  #   end
  # end

end
