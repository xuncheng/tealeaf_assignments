# Calculator App

puts "What's the first number?"
num1 = gets.chomp

puts "What's the second number?"
num2 = gets.chomp

puts "What operation would you like to perform? 1)add 2)sub 3)multiply 4)divide:"
operation = gets.chomp

result = case operation
         when '1' then "#{num1} + #{num2} = #{num1.to_i + num2.to_i}"
         when '2' then "#{num1} - #{num2} = #{num1.to_i - num2.to_i}"
         when '3' then "#{num1} * #{num2} = #{num1.to_i * num2.to_i}"
         when '4' then "#{num1} / #{num2} = #{num1.to_f / num2.to_f}"
         else "I don't understand the operation '#{operation}'."
         end

puts result

