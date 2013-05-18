# Object Oriented Blackjack game
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class Blackjack
  attr_accessor :deck, :player, :dealer
  def initialize
    @deck = Deck.new
    @player = Player.new("Player1")
    @dealer = Dealer.new
  end

  def set_player_name
    print "First, tell me what your name is? "
    player.name = gets.chomp.downcase.capitalize

    puts "Hello #{player.name}, welcome to Blackjack!"
  end

  def deal_cards
    puts ""
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    puts "=> Cards dealt. There are now #{deck.count} cards in the deck."
  end

  def show_hand
    dealer.show_flop
    player.show_flop
  end

  def blackjack_or_busted?(player_or_dealer)
    if player_or_dealer.total == 21
      if player_or_dealer.is_a?(Dealer)
        puts "**** Sorry #{player.name}, dealer has hit blackjack. You lose! ****"
      else
        puts "**** Congratulations! You has hit blackjack. You win! ****"
      end
      play_again?
    elsif player_or_dealer.is_busted?
      if player_or_dealer.is_a?(Dealer)
        puts "**** Congratulations, dealer has busted. You win! ****"
      else
        puts "**** Sorry #{player.name}, you busted. You lose! ****"
      end
      play_again?
    end 
  end

  def player_turn
    puts ""
    puts "=> ---- #{player.name}'s turn: ----"

    blackjack_or_busted?(player)
    while !player.is_busted?
      print "What would you like to do 1)hit 2)stay? "
      hit_or_stay = gets.chomp

      if !['1', '2'].include?(hit_or_stay)
        puts "Error: You MUST enter 1 or 2"
        next
      end

      if hit_or_stay == '2'
        puts "You choose stay! Your total is #{player.total}"
        puts ""
        puts "=> Dealer has '#{dealer.cards[0]}' and '#{dealer.cards[1]}', for a total of: #{dealer.total}"
        break
      end

      # hit
      new_card = deck.deal_one
      puts "=> There are now #{deck.count} cards in the deck."
      puts "=> Dealing new card to you: '#{new_card}'"
      player.add_card(new_card)
      puts "=> You total is now: #{player.total}"
      puts ""

      blackjack_or_busted?(player)
    end
  end

  def dealer_turn
    puts ""
    puts "=> ---- Dealer's turn: ----"

    blackjack_or_busted?(dealer)
    while dealer.total < 17 # auto hit
      puts "=> Dealer auto hits..."
      new_card = deck.deal_one
      puts "=> There are now #{deck.count} cards in the deck."
      puts "=> Dealing new card for Dealer '#{new_card}'"
      dealer.add_card(new_card)
      puts "=> Dealer total is now: #{dealer.total}"
      puts ""

      blackjack_or_busted?(dealer)
    end
  end

  def who_won?
    puts ""
    dealer.show_hand
    player.show_hand
    if player.total > dealer.total
      puts "**** Congratulations, you win! ****"
    elsif player.total < dealer.total
      puts "**** Sorry #{player.name}, you lose! ****"
    else
      puts "**** Oh, you and dealer have equal total of #{player.total}. It's tie! ****"
    end
    play_again?
  end

  def play_again?
    puts ""
    print "Would you like to play again[Y/n]? "
    if gets.chomp.upcase[0] == 'Y'
      puts "Starting new game..."
      puts ""
      deck = Deck.new
      player.cards = []
      dealer.cards = []
      start
    else
      puts ""
      puts "Goodbye #{player.name}, thanks for playing!"
      exit
    end
  end

  def start
    set_player_name
    deal_cards
    show_hand
    player_turn
    dealer_turn
    who_won?
  end
end

blackjack = Blackjack.new
blackjack.start
