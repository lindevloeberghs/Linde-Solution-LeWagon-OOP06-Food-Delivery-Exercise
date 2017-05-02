class Router

  def initialize(sessions_controller, meals_controller, customers_controller, orders_controller)
    @sessions_controller = sessions_controller
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @orders_controller = orders_controller
    @running = true
    @current_user = nil # optional
  end

  def run
    puts "Welcome to Restaurant Wagon"

    while @running
      @current_user = sign_in
      while @current_user
        display_menu(@current_user)
        action = ask_user_for_action
        print `clear`
        route_action(@current_user, action)
      end
      print `clear`
    end
  end

  private

  def sign_in
    @sessions_controller.sign_in
  end

  def display_menu(current_user)
    if current_user.manager?
      display_manager_menu
    else
      display_delivery_guy_menu
    end
  end

  def display_manager_menu
    puts "1. Add a meal"
    puts "2. List available meals"
    puts "3. Add a customer"
    puts "4. List customers"
    puts "5. Add an order"
    puts "6. View undelivered orders"
    puts "7. Remove a meal"
    puts "9. Log Out"
    puts "0. Exit"
  end

  def display_delivery_guy_menu
    puts "1. List my orders"
    puts "2. Mark an order as delivered"
    puts "9. Log Out"
    puts "0. Exit"
  end

  def route_action(current_user, action)
    if current_user.manager?
      route_manager_action(action)
    else
      route_delivery_guy_action(action)
    end
  end

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 7 then @meals_controller.delete
    when 9 then logout
    when 0 then stop
    else puts "Wrong action"
    end
  end

  def route_delivery_guy_action(action)
    case action
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    when 9 then logout
    when 0 then stop
    else puts "Wrong action"
    end
  end

  def logout
    @current_user = nil
  end

  def stop
    logout
    @running = false
  end

  def ask_user_for_action
    puts "What do you want to do next?"
    print "> "
    gets.chomp.to_i
  end

end
