require_relative "base_view"
require 'io/console'

class SessionsView < BaseView

  def ask_for_password
    puts "password?"
    STDIN.noecho(&:gets).chomp
  end

  def wrong_credentials
    puts "Wrong credentials, try again"
  end

  def welcome(employee)
    puts "Welcome #{employee.username.capitalize}!"
  end

end
