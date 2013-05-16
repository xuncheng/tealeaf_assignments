require_relative 'shared_function'

class Dealer
  include SharedFunction
  attr_accessor :cards
  def initialize
    @cards = []
  end

  def add_card(new_card)
    cards << new_card
  end

  def show_cards
    cards.join(', ')
  end
end