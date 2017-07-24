require 'colorize'

class Store
  attr_accessor :name, :inventory, :user
  def initialize(name, user)
    @name = name
    @user = user
    @inventory = [
      { name: 'Shoes', price: 50, qty: 2 },
      { name: 'Shirt', price: 30, qty: 3 },
      { name: 'Pants', price: 60, qty: 5 }
    ]
  end

  def display_items
    @inventory.each_with_index do |item, index|
      name = item[:name]
      price = item[:price]
      qty = item[:qty]
      color = (price > @user.wallet_amt || qty == 0) ? :red : :green
      puts "#{index + 1}: #{name}: $#{price} (#{qty})".colorize(color)
    end
  end

  def shop
    display_items
    puts "Select an item to buy"
    choice = gets.to_i
    if choice > 0 && choice <= @inventory.length
      item = @inventory[choice - 1]
      if item[:qty] == 0
        puts "Item is out of stock"
      else
        purchased = @user.update_inventory(item)
        item[:qty] -= 1 if purchased
      end

      puts "Do you want to keep shopping (y/n)"
      cont = gets.strip.downcase
      shop if cont == 'y' || cont == 'yes'
    else
      puts "Invalid choice.  Try again"
      shop
    end
  end

  def add_items
    puts "What do you want to do?"
    puts "1. Add Item"
    puts "2. Main Menu"
    choice = gets.to_i
    case choice
    when 1
      puts "What is the name of the item"
      name = gets.strip
      puts "What is the price of the item"
      price = gets.to_f
      puts "How many do you want to add?"
      qty = gets.to_i
      @inventory << { name: name, price: price, qty: qty }
      add_items
    when 2
      puts "Store has been updated"
    else
      add_items
    end
  end


  def sell
    if @user.inventory.any?
      puts "What do you want to sell"
      @user.receipt
      choice = gets.to_i
      if choice > 0 && choice <= @user.inventory.length
        item = @user.inventory[choice - 1]
        stock = @inventory.find { |i| i[:name] == item[:name] }
        stock[:qty] += 1
        @user.wallet_amt += item[:price]
      else
        puts "Invalid choice"
        sell
      end
    else
      puts "You have nothing to sell"
    end
  end
end
