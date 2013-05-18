require_relative 'hand'

class Player
  include Hand
  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def show_flop
    puts "=> You have: '#{cards[0]}' and '#{cards[1]}', for a total of : #{total}"
  end
end
