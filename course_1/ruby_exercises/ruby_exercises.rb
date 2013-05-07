array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# 1. print out each value
print "1. "
array.each { |x| print "#{x} " }
puts "\n"

# 2. print out values greater than 5
print "2. "
array.each { |x| print "#{x} " if x > 5 }
puts "\n"

# 3. extract all odd numbers into a new array
print "3. "
array_odd = array.select { |x| x % 2 != 0 }
print "#{array_odd}\n"

# 4. Append "11" to the end of the array. Prepend "0" to the beginning.
print "4. "
array.unshift(0).push(11)
print "#{array}\n"

# 5. Get rid of "11". And append a "3".
print "5. "
array.pop
array << 3
print "#{array}\n"

# 6. Get rid of duplicates without specifically removing any one value.
print "6. "
#print "#{array.uniq}\n"
print "#{array}\n"

# 7. What's the major difference between an Array and a Hash?
puts "Arrays are ordered, integer-indexed collection of any object."
puts "Array indexing starts at 0."
puts "A Hash is a collection of key-value pairs. It is similar to"
puts "an array, except that indexing is done via arbitrary keys of"
puts "any object type, not an integer index."

# 8. Create a Hash using both Ruby 1.8 and 1.9 syntax.
print "8. "
old_hash = { :a => 1, :b => 2, :c => 3, :d => 4 }
new_hash = { a: 1, b: 2, c: 3, d: 4 }

puts old_hash
puts "#{new_hash}"

# Suppose you have a h = {a:1, b:2, c:3, d:4}
# 9. Get the value of key "b".
print "9. "
h = { a: 1, b: 2, c: 3, d: 4 }
puts h[:b]

# 10. Add to this hash the key:value pair {e:5}
print "10. "
h[:e] = 5
puts h

# 13. Remove all key:value pairs whose value is less than 3.5
print "13. "
h.delete_if { |k,v| v < 3.5 }
puts h

# 14. Can hash values be arrays? Can you have an array of hashes? (give examples)
print "14. "
array_hash = { a: [1, 3], b: [2, 4] }
hash_array = [ { a: 1, b: 2}, { c: 3, d: 4 } ]
puts array_hash
print "#{hash_array}\n"

# 15. Look at several Rails/Ruby online API sources and say which one your like best and why.
puts "http://www.ruby-doc.org/core-1.9.3/"
