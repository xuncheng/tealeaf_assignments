class Deck
  attr_accessor :cards
  def initialize(number_of_decks=1)
    @cards = []
    init_cards(number_of_decks)
  end

  def count
    cards.count
  end

  def deal_one
    cards.pop
  end

  private
  def init_cards(number_of_decks)
    suits = ['Hearts', 'Diamonds', 'Spades', 'Club']
    faces = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queue', 'King', 'Ace']
    number_of_decks.times do
      suits.each do |suit|
        faces.each do |face|
          @cards << Card.new(suit, face)
        end
      end
    end
    @cards.shuffle!
  end
end
