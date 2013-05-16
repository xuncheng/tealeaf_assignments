module SharedFunction
  def calculate_total
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

    # correct for Aces
    faces.select { |e| e == "Ace" }.count.times do
      total -= 10 if total > 21
    end

    total
  end
end