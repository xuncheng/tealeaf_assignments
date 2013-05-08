# Interactive command line blackjack game.

def calculate_total(cards)
  # [['Hearts', '3'], ['Spades', 'Jack'], ...]
  arr = cards.map { |e| e[1] }
  total = 0

  arr.each do |value|
    if value == "Aces"
      total += 11
    elsif value.to_i == 0 # Jack, Queen, King
      total += 10
    else
      total += value.to_i
    end
  end

  # correct for Aces
  arr.select { |e| e == "Aces" }.count.times do
    total -= 10 if total > 21
  end

  total
end

puts "Welcome to Blackjack!"
puts "=> ------ Game Start ------"

suits = ['Hearts', 'Diamonds', 'Spades', 'Club']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Aces']

deck = suits.product(cards)
deck.shuffle!

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
puts "=> Dealer's first card is: #{dealercards[0][1]} of #{dealercards[0][0]}"
puts "=> Dealer's second card is: #{dealercards[1][1]} of #{dealercards[1][0]}"
puts "=> Dealer's total is #{dealertotal}"

puts ""
puts "=> ------ Your cards ------"
puts "=> Your first card is: #{mycards[0][1]} of #{mycards[0][0]}"
puts "=> Your second card is: #{mycards[1][1]} of #{mycards[1][0]}"
puts "=> Your total is #{mytotal}"

# Player

if mytotal == 21
  puts ""
  puts "**** Congratulation! You has hit blackjack. You Win! ****"
end

while mytotal < 21
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
      puts ""
      puts "**** Congratulation! You has hit blackjack. You win! ****"
      puts "=> ------ Game Over ------"
      exit
    elsif mytotal > 21
      puts ""
      puts "**** Oh, you busted! Your total is #{mytotal}. ****"
      puts "=> ------ Game Over ------"
      exit
    end
  elsif hit_or_stay == '2'
    break
  else
    puts "Oh, error command! You must enter 1) hit 2) stay."
  end
end

# Dealer

while dealertotal < 17
  puts ""
  dealercards << deck.pop
  puts "=> There are now #{deck.count} cards in the deck."
  puts "=> Dealer drew #{dealercards.last[1]} of #{dealercards.last[0]}"
  dealertotal = calculate_total(dealercards)
  puts "=> Dealer's total is #{dealertotal}"
  if dealertotal == 21
    puts ""
    puts "**** Wow! Dealer has hit blackjack. You lost! ****"
    puts "=> ------ Game Over ------"
    exit
  elsif dealertotal > 21
    puts ""
    puts "**** Oh, dealer busted! Dealer's total is #{dealertotal}. ****"
    puts "=> ------ Game Over ------"
    exit
  end
end

# Compare

puts ""
if mytotal > dealertotal
  puts "**** You win! Your total is #{mytotal}, Dealer's total is #{dealertotal}. ****"
  puts "=> ------ Game Over ------"
elsif mytotal == dealertotal
  puts "**** Oh, you and dealer have the same point: #{mytotal}, it's a tie! ****"
  puts "=> ------ Game Over ------"
elsif mytotal < dealertotal
  puts "**** You lost! Your total is #{mytotal}, Dealer's total is #{dealertotal}. ****"
  puts "=> ------ Game Over ------"
end

