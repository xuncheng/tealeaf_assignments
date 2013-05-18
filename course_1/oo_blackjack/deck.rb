require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    init_cards
  end

  def deal_one
    cards.pop
  end

  def count
    cards.count
  end

  private
  def init_cards
    suits = ['Hearts', 'Diamonds', 'Spades', 'Club']
    faces = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
    suits.each do |suit|
      faces.each do |face|
        @cards << Card.new(suit, face)
      end
    end
    cards.shuffle!
  end
end
