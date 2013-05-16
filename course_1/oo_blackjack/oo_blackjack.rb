# Object Oriented Blackjack game.
require 'pry'
require_relative 'card'
require_relative 'dealer'
require_relative 'deck'
require_relative 'player'

puts "Welcome to Blackjack!"
print "First, tell me what your name is? "
name = gets.chomp.downcase.capitalize
player = Player.new(name)

puts "Hello #{player.name}, welcome to Blackjack world!"

deck = Deck.new(4)
game_continued = true

while game_continued
  if deck.count < 52
    puts "=> Shuffling the deck..."
    deck = Deck.new(4)
    sleep(1)
  end

  # Deal Cards
  winner = nil
  dealer = Dealer.new

  player.add_card(deck.deal_one)
  dealer.add_card(deck.deal_one)
  player.add_card(deck.deal_one)
  dealer.add_card(deck.deal_one)

  puts "=> Cards dealt. There are now #{deck.count} cards in the deck."

  dealer_total = dealer.calculate_total
  player_total = player.calculate_total

  # Show Cards
  puts "=> Dealer is showing #{dealer.cards[1]}"

  puts "=> You have: #{player.show_cards}, for a total of: #{player_total}"

  # player turn
  if player_total == dealer_total && player_total == 21
    puts "**** Oh, you and dealer have hit blackjack. It's tie! ****"
    winner = "NIL"
  elsif player_total == 21
    puts "**** Congratulations! You has hit blackjack. You win! ****"
    winner = "PLAYER"
  elsif dealer_total == 21
    puts "**** Sorry #{player.name}, dealer has hit blackjack. You lose! *****"
    winner = "DEALER"
  end

  while player_total < 21
    puts ""
    print "What would you like to do 1) hit 2) stay ? "
    hit_or_stay = gets.chomp

    if !['1', '2'].include?(hit_or_stay)
      puts "Error: You must enter 1 or 2"
      next
    end

    if hit_or_stay == '2'
      puts "You choose stay! You total is #{player_total}"
      break
    end

    # hit
    new_card = deck.deal_one
    puts "=> There are now #{deck.count} cards in the deck."
    puts "=> Dealing new card to you: #{new_card}"
    player.add_card(new_card)
    player_total = player.calculate_total
    puts "=> You total is now: #{player_total}"

    if player_total == 21
      puts "**** Congratulations! You has hit blackjack. You win! ****"
      winner = "PLAYER"
    elsif player_total > 21
      puts "**** Sorry #{player.name}, you busted. You lose! ****"
      winner = "DEALER"
    end
  end

  # Show dealer's cards
  if !winner
    puts ""
    puts "=> Dealer has: #{dealer.show_cards}, for a total of: #{dealer_total}"
  end

  # Dealer turn
  if dealer_total == 21
    puts "**** Sorry #{player.name}, dealer has hit blackjack. You lose! ****"
    winner = "DEALER"
  end

  while !winner && dealer_total < 17 # auto hit
    puts ""
    puts "=> Dealer auto hits..."
    new_card = deck.deal_one
    puts "=> There are now #{deck.count} cards in the deck."
    puts "=> Dealing new card for Dealer #{new_card}"
    dealer.add_card(new_card)
    dealer_total = dealer.calculate_total
    puts "=> Dealer total is now: #{dealer_total}"

    if dealer_total == 21
      puts "**** Sorry #{player.name}, dealer has hit blackjack. You lose! ****"
      winner = "DEALER"
    elsif dealer_total > 21
      puts "**** Congratulations, dealer has busted. You win! ****"
      winner = "PLAYER"
    end
  end

  # Compare hands
  if !winner
    puts ""
    puts "=> Dealer's Cards: #{dealer.show_cards}"
    #dealer_cards.each { |card| print "'#{card.reverse.join(' of ')}' " }

    puts "=> Your Cards: #{player.show_cards}"
    #player_cards.each { |card| print "'#{card.reverse.join(' of ')}' "}

    if player_total > dealer_total
      puts "**** Congratulations, you win! ****"
    elsif player_total < dealer_total
      puts "**** Sorry #{player.name}, you lose! ****"
    else
      puts "**** Oh, you and dealer have equal totals of #{player_total}. It's tie! ****"
    end
  end

  puts ""
  print "Would you like to play again[Y/n]?"
  game_continued = false if gets.chomp.upcase[0] != 'Y'
end

puts ""
puts "Goodbye #{name}, thanks for playing!"
