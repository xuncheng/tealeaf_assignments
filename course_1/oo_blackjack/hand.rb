module Hand
  def show_hand
    print "=> #{name}'s Cards: #{cards.join(', ')}"
    puts ""
  end

  def total
    # [['Hearts', '2'], ['Spades', 'Jack'], ...]
    total = 0
    faces = cards.map { |card| card.face }

    faces.each do |face|
      if face == "Ace"
        total += 11
      elsif face.to_i == 0 # Jack, Queen, King
        total += 10
      else
        total += face.to_i
      end
    end

    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total > 21
  end
end
