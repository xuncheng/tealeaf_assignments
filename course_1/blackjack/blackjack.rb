# Interactive command line blackjack game.

def calculate_total(cards)
  # [['Hearts', '3'], ['Spades', 'Jack'], ...]
  arr = cards.map { |e| e[1] }
  total = 0

  arr.each do |value|
    if value == "Ace"
      total += 11
    elsif value.to_i == 0 # Jack, Queen, King
      total += 10
    else
      total += value.to_i
    end
  end

  # correct for Aces
  arr.select { |e| e == "Ace" }.count.times do
    total -= 10 if total > 21
  end

  total
end

puts "Welcome to Blackjack!"
puts "=> ------ Game Start ------"

suits = ['Hearts', 'Diamonds', 'Spades', 'Club']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

game_continued = true
player_won_total = 0
player_lost_total = 0
tie_total = 0

while game_continued
  game_over = false
  hands_total = player_won_total + player_lost_total + tie_total
  if hands_total % 10 == 0
    puts "==> ...Bring new cards..." if hands_total != 0
    deck = suits.product(cards) * 4 # four is packs of cards quantity
    deck.shuffle!
  end

  # Deal Cards

  puts "=> Dealing cards..."
  mycards = []
  dealercards = []

  mycards << deck.pop
  dealercards << deck.pop
  mycards << deck.pop
  dealercards << deck.pop

  puts "=> Cards dealt. There are now #{deck.count} cards in the deck."

  dealertotal = calculate_total(dealercards)
  mytotal = calculate_total(mycards)

  # Show Cardd

  puts ""
  puts "=> ------ Dealer's cards: ------"
  puts "=> Dealer's first card is hidden."
  puts "=> Dealer's second card is: #{dealercards[1][1]} of #{dealercards[1][0]}"

  puts ""
  puts "=> ------ Your cards ------"
  puts "=> Your first card is: #{mycards[0][1]} of #{mycards[0][0]}"
  puts "=> Your second card is: #{mycards[1][1]} of #{mycards[1][0]}"
  puts "=> Your total is #{mytotal}"

  # Player

  if mytotal == 21
    game_over = true
    player_won_total += 1
    puts ""
    puts "**** Congratulation! You has hit blackjack. You Win! ****"
    puts "=> ------ Dealer's cards: ------"
    puts "=> Dealer's first card is: #{dealercards[0][1]} of #{dealercards[0][0]}"
    puts "=> Dealer's second card is: #{dealercards[1][1]} of #{dealercards[1][0]}"
    puts "=> Dealer's total is #{dealertotal}"
  end

  while mytotal < 21 && !game_over
    puts ""
    puts "What would you like to do? 1) hit 2) stay"
    hit_or_stay = gets.chomp
    if hit_or_stay == '1'
      mycards << deck.pop
      puts "=> There are now #{deck.count} cards in the deck."
      puts "=> You drew #{mycards.last[1]} of #{mycards.last[0]}"
      mytotal = calculate_total(mycards)
      puts "=> Your total is #{mytotal}"
      if mytotal == 21
        game_over = true
        player_won_total += 1
        puts "**** Congratulation! You has hit blackjack. You win! ****"
        puts "=> ------ Dealer's cards: ------"
        puts "=> Dealer's first card is: #{dealercards[0][1]} of #{dealercards[0][0]}"
        puts "=> Dealer's second card is: #{dealercards[1][1]} of #{dealercards[1][0]}"
        puts "=> Dealer's total is #{dealertotal}"
      elsif mytotal > 21
        game_over = true
        player_lost_total += 1
        puts "**** Oh, you busted! Your total is #{mytotal}. ****"
        puts "=> ------ Dealer's cards: ------"
        puts "=> Dealer's first card is: #{dealercards[0][1]} of #{dealercards[0][0]}"
        puts "=> Dealer's second card is: #{dealercards[1][1]} of #{dealercards[1][0]}"
        puts "=> Dealer's total is #{dealertotal}"
      end
    elsif hit_or_stay == '2'
      puts "**** You choose stay! Your total is #{mytotal}"
      puts "=> ------ Dealer's cards: ------"
      puts "=> Dealer's first card is: #{dealercards[0][1]} of #{dealercards[0][0]}"
      puts "=> Dealer's second card is: #{dealercards[1][1]} of #{dealercards[1][0]}"
      puts "=> Dealer's total is #{dealertotal}"
      break
    else
      puts "Oh, error command! You must enter 1) hit 2) stay."
    end
  end

  # Dealer

  while dealertotal < 17 && !game_over
    puts ""
    dealercards << deck.pop
    puts "=> There are now #{deck.count} cards in the deck."
    puts "=> Dealer drew #{dealercards.last[1]} of #{dealercards.last[0]}"
    dealertotal = calculate_total(dealercards)
    puts "=> Dealer's total is #{dealertotal}"
    if dealertotal == 21
      game_over = true
      player_lost_total += 1
      puts ""
      puts "**** Wow! Dealer has hit blackjack. You lost! ****"
    elsif dealertotal > 21
      game_over = true
      player_won_total += 1
      puts ""
      puts "**** Oh, dealer busted! Dealer's total is #{dealertotal}. ****"
    end
  end

  # Compare

  if !game_over
    puts ""
    if mytotal > dealertotal
      player_won_total += 1
      puts "**** You win! Your total is #{mytotal}, Dealer's total is #{dealertotal}. ****"
    elsif mytotal == dealertotal
      tie_total += 1
      puts "**** Oh, you and dealer have the same point: #{mytotal}, it's a tie! ****"
    elsif mytotal < dealertotal
      player_lost_total += 1
      puts "**** You lost! Your total is #{mytotal}, Dealer's total is #{dealertotal}. ****"
    end
  end

  puts ""
  puts "So far, you have played #{player_won_total + player_lost_total + tie_total} hands, won #{player_won_total} hands, lost #{player_lost_total} hands and tie #{tie_total} hands."
  print "Would you like to play again[Y/n]?"
  game_continued = false if gets.chomp.upcase[0] != 'Y'
end

