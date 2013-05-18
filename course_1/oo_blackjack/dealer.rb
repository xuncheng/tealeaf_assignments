require_relative 'hand'

class Dealer
  include Hand
  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_flop
    puts "=> Dealer is showing '#{cards[1]}'."
  end
end
