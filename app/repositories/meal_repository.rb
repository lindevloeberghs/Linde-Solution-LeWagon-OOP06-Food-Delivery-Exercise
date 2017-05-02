require_relative "base_repository"
require_relative "../models/meal"

class MealRepository < BaseRepository

  def delete_meal(id)
    @elements.delete_if { |meal| meal.id == id }
    write_csv
  end

  private

  def build_element(row)
    row[:id]    = row[:id].to_i          # Convert column to Fixnum
    row[:price] = row[:price].to_i       # Convert column to Fixnum
    Meal.new(row)
  end

end
