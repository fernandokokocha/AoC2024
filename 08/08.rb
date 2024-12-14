# part 1
# 
# table = []
# ans = []

# File.open("./08-input.txt", "r").each_line do |line|
#   table << line.chop.chars
# end

# height = table.length
# width = table[0].length

# puts "H:#{height} W:#{width}"

# table.each_with_index do |row, i|
#   row.each_with_index do |cell, j|
#     next if cell == '.'
#     table.each_with_index do |row2, i2|
#       row2.each_with_index do |cell2, j2|
#         next if cell2 == '.'
#         next if cell != cell2
#         next if i == i2 && j == j2

#         antinode_x = 2*i2 - i
#         next if (antinode_x < 0) || (antinode_x > (height - 1))
#         antinode_y = 2*j2 - j
#         next if (antinode_y < 0) || (antinode_y > (width - 1))

#         antinode = [antinode_x, antinode_y]
#         # puts "  GOOD #{i}x#{j} (#{cell}) with #{i2}x#{j2} (#{cell2}), antinode is #{antinode.inspect}"
#         if ans.include?(antinode)
#           next
#         else
#           ans << antinode
#         end
#       end
#     end
#   end
# end

# puts "ANSWER: #{ans.length}"

# part 2

$table = []
$ans = []

File.open("./08-input.txt", "r").each_line do |line|
  $table << line.chop.chars
end

height = $table.length
width = $table[0].length

# puts "H:#{height} W:#{width}"

def insert_if_not_exists(i, j)
  # puts " iine [#{i}, #{j}]"
  if $ans.include?([i, j])
    return
  else
    $ans << [i, j]
  end
end

$table.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    next if cell == '.'
    $table.each_with_index do |row2, i2|
      row2.each_with_index do |cell2, j2|
        next if cell2 == '.'
        next if cell != cell2
        next if i == i2 && j == j2

        # puts "check #{i}x#{j} (#{cell}) with #{i2}x#{j2} (#{cell2})"

        insert_if_not_exists(i, j)
        insert_if_not_exists(i2, j2)

        antinode_x = 2*i2 - i
        antinode_y = 2*j2 - j

        while ((antinode_x >= 0) && (antinode_x <= (height - 1)) && (antinode_y >= 0) && (antinode_y <= (width - 1)))
          insert_if_not_exists(antinode_x, antinode_y)
          antinode_x += (i2 - i)
          antinode_y += (j2 - j)
        end

        # puts "  GOOD #{i}x#{j} (#{cell}) with #{i2}x#{j2} (#{cell2}), antinode is #{antinode.inspect}"

      end
    end
  end
end

puts "ANSWER: #{$ans.length}"