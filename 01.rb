## part 1

# a1 = []
# a2 = []

# while line=gets
#   n = line.split
#   a1 << Integer(n[0])
#   a2 << Integer(n[1])
# end

# a1.sort!
# a2.sort!

# ans = a1.zip(a2).reduce(0) do |sum, pair|
#   sum += ((pair[0] - pair[1]).abs)
# end

# puts "ANSWER #{ans}"


a1 = []
a2 = []

while line=gets
  n = line.split
  a1 << Integer(n[0])
  a2 << Integer(n[1])
end

a2hash = a2.group_by(&:itself).transform_values(&:count)

ans = a1.reduce(0) do |sum, item|
  sum += (item * a2hash.fetch(item, 0))
end

puts "ANSWER #{ans}"
