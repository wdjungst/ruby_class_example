class User
  attr_accessor :name, :wallet_amt, :inventory

  def initialize(name, amt)
    @name = name
    @wallet_amt = amt
    @inventory = []
  end

  def show_inventory
    items = []

    #This is the best way to make a deep duplicate of an array of objects without mutating
    inv = Marshal.load Marshal::dump(@inventory)

    inv.each_with_index do |item, index|
      if index = items.find_index { |i| i[:name] == item[:name] }
        items[index][:price] += item[:price]
      else
        items << item
      end
    end

    items.each { |item| puts "#{item[:name]}: Total: #{item[:price]}" }
  end

  def receipt
    @inventory.each_with_index { |item, i | puts "#{i + 1}: #{item[:name]} - #{item[:price]}" }
  end

  def update_inventory(item)
    price = item[:price]
    if price > @wallet_amt
      puts "You don't have enough money"
      false
    else
      @inventory << item
      @wallet_amt -= price
      true
    end
  end
end
