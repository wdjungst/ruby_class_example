require_relative 'user'
require_relative 'store'

class App
  attr_accessor :user

  def initialize
    puts "What is your name"
    name = gets.strip
    puts "How much money do you have with you?"
    amt = gets.to_f
    puts "What store do you want to shop at"
    store_name = gets.strip
    @user = User.new(name, amt)
    @store = Store.new(store_name, @user)
  end

  def menu
    puts "What do you want to do today?"
    puts "1. Buy something"
    puts "2. Sell something"
    puts "3. Display your inventory"
    puts "4. See how much money you have left"
    puts "5. Add items to store"
    puts "6. Leave"
    menu_option(gets.to_i)
  end

  def menu_option(choice)
    case choice
    when 1
      @store.shop
    when 2
      @store.sell
    when 3
      @user.show_inventory
    when 4
      puts "You have #{@user.wallet_amt} left to spend\n"
    when 5
      @store.add_items
    when 6
      puts "Thank you for shopping at #{@store.name}\n"
      exit
    else
      puts "Invalid Choice Try Again"
      menu
    end

    menu
  end

end

app = App.new
app.menu

