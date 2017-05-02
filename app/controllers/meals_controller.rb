require_relative "../models/meal.rb"
require_relative "../views/meals_view.rb"

class MealsController

  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def list
    display_meals
  end

  def add
    name = @view.ask_for(:name)
    price = @view.ask_for_integer(:price)
    new_meal = Meal.new(name: name, price: price)
    @meal_repository.add(new_meal)
    display_meals
  end

  def delete
    display_meals
    meal_id = @view.ask_for_integer(:id)
    @meal_repository.delete_meal(meal_id)
  end

  private

  def display_meals
    meals = @meal_repository.all
    @view.display(meals)
  end

end
