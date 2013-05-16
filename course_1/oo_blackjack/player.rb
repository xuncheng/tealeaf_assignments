require_relative 'shared_function'

class Player
  include SharedFunction
  attr_reader :name, :cards
  def initialize(name)
    @name = name
    @cards = []
  end

  def add_card(new_card)
    cards << new_card
  end

  def show_cards
    cards.join(', ')
  end
end
