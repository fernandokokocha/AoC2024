# part 1

# table = []
# $ans = Hash.new
#
# File.open("./10-input.txt", "r").each_line do |line|
#   table << line.chop.chars.map(&:to_i)
# end
#
# $height = table.length
# $width = table[0].length
#
# def insert(start_i, start_j, i, j)
#   # puts "insert #{start_i} #{start_j} #{i} #{j}"
#   key = "#{start_i}-#{start_j}"
#   value = "#{i}-#{j}"
#   values = $ans.fetch(key, [])
#   unless values.include?(value)
#     values << value
#     $ans[key] = values
#   end
# end
#
# def find(table, i, j, number, start_i, start_j)
#   # puts "find #{i}-#{j} #{number}=#{table[i][j]}?"
#   if table[i][j] != number
#     # puts " returning 0"
#     return
#   end
#   if number == 9
#     insert(start_i, start_j, i, j)
#     # puts " returning 1"
#     return
#   end
#
#   if i > 0
#     find(table, i-1, j, number+1, start_i, start_j)
#   end
#   if i < $height - 1
#     find(table, i+1, j, number+1, start_i, start_j)
#   end
#   if j > 0
#     find(table, i, j-1, number+1, start_i, start_j)
#   end
#   if j < $width - 1
#     find(table, i, j+1, number+1, start_i, start_j)
#   end
#
#   # puts " returning #{ret}"
# end
#
# table.each_with_index do |row, i|
#   row.each_with_index do |cell, j|
#     next if table[i][j] != 0
#     find(table, i, j, table[i][j], i, j)
#   end
# end
#
# a = 0
# $ans.entries.each do |key, value|
#   # puts "#{key}: #{value}"
#   a += value.length
# end
#
# puts "ANSWER: #{a}"

# part 2

table = []
$ans = 0

File.open("./10-test-input.txt", "r").each_line do |line|
  table << line.chop.chars.map(&:to_i)
end

$height = table.length
$width = table[0].length

def find(table, i, j, number)
  # puts "find #{i}-#{j} #{number}=#{table[i][j]}?"
  if table[i][j] != number
    # puts " returning 0"
    return 0
  end
  if number == 9
    # puts " returning 1"
    return 1
  end

  ans = 0
  if i > 0
    ans += find(table, i-1, j, number+1)
  end
  if i < $height - 1
    ans += find(table, i+1, j, number+1)
  end
  if j > 0
    ans += find(table, i, j-1, number+1)
  end
  if j < $width - 1
    ans += find(table, i, j+1, number+1)
  end

  # puts " returning #{ret}"
  ans
end

table.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    next if table[i][j] != 0
    $ans += find(table, i, j, table[i][j])
  end
end

puts "ANSWER: #{$ans}"
