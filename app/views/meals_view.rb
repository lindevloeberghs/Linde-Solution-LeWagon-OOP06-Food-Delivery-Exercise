require_relative "base_view"

class MealsView < BaseView

  def display(meals)
    meals.each do |meal|
      puts "MEAL #{meal.id} - #{meal.name} - #{meal.price} EUR"
    end
  end

end
