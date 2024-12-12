# part 1
# table = []
# walked = []
# ans = 0
#
# File.open("./12-input.txt", "r").each_line do |line|
#   table << line.chop.chars
# end
#
# height = table.length
# width = table[0].length
#
# def walk(i, j, table, walked, height, width, char)
#   walked << [i, j]
#
#   area = 1
#   perimeter = 0
#   if (i == 0) or (table[i-1][j] != char)
#     perimeter+=1
#   end
#   if (i == height-1) or (table[i+1][j] != char)
#     perimeter+=1
#   end
#   if (j == 0) or (table[i][j-1] != char)
#     perimeter+=1
#   end
#   if (j == width-1) or (table[i][j+1] != char)
#     perimeter+=1
#   end
#
#
#   if i > 0 && table[i-1][j] == char && !walked.include?([i-1, j])
#     up = walk(i-1, j, table, walked, height, width, char)
#     area += up[:area]
#     perimeter += up[:perimeter]
#   end
#   if i < height-1 && table[i+1][j] == char && !walked.include?([i+1, j])
#     up = walk(i+1, j, table, walked, height, width, char)
#     area += up[:area]
#     perimeter += up[:perimeter]
#   end
#   if j > 0 && table[i][j-1] == char && !walked.include?([i, j-1])
#     up = walk(i, j-1, table, walked, height, width, char)
#     area += up[:area]
#     perimeter += up[:perimeter]
#   end
#   if j < width - 1 && table[i][j+1] == char && !walked.include?([i, j+1])
#     up = walk(i, j+1, table, walked, height, width, char)
#     area += up[:area]
#     perimeter += up[:perimeter]
#   end
#
#   { area: area, perimeter: perimeter}
# end
#
# (0...height).each do |i|
#   puts "#{i} of #{height}"
#   (0...width).each do |j|
#     next if walked.include? [i, j]
#     partial = walk(i, j, table, walked, height, width, table[i][j])
#     ans += partial[:area] * partial[:perimeter]
#   end
# end
#
# puts "ANSWER: #{ans}"

table = []
$walked = []
ans = 0

File.open("./12-test5-input.txt", "r").each_line do |line|
  table << line.chop.chars
  $walked << Array.new(line.chop.length).map{ |e| false }
end

height = table.length
width = table[0].length

$walked_dump = Marshal.dump($walked)

def calc_knees(current_walked, height, width)
  ans = 0
  (0...height-1).each do |i|
    # puts "#{i} of #{height}"
    (0...width-1).each do |j|
      points = [
        current_walked[i][j],
        current_walked[i+1][j],
        current_walked[i][j+1],
        current_walked[i+1][j+1],
      ]
      ans += 1 if (points - [false]).length == 3
    end
  end

  ans
end

def walk(i, j, table, walked, height, width, char, current_walked)
  walked[i][j] = true
  current_walked[i][j] = true

  area = 1

  if i > 0 && table[i-1][j] == char && !walked[i-1][j]
    area += walk(i-1, j, table, walked, height, width, char, current_walked)
  end
  if i < height-1 && table[i+1][j] == char && !walked[i+1][j]
    area += walk(i+1, j, table, walked, height, width, char, current_walked)
  end
  if j > 0 && table[i][j-1] == char && !walked[i][j-1]
    area += walk(i, j-1, table, walked, height, width, char, current_walked)
  end
  if j < width - 1 && table[i][j+1] == char && !walked[i][j+1]
    area += walk(i, j+1, table, walked, height, width, char, current_walked)
  end

  area
end

(0...height).each do |i|
  # puts "#{i} of #{height}"
  (0...width).each do |j|
    next if $walked[i][j]

    current_walked = Marshal.load($walked_dump)
    area = walk(i, j, table, $walked, height, width, table[i][j], current_walked)
    knees = calc_knees(current_walked, height, width)
    # puts "#{table[i][j]}: #{area}, #{knees}"
    rating = 4 + (2 * knees)
    ans += (area * rating)
  end
end

puts "ANSWER: #{ans}"
