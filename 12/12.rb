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

File.open("./12-input.txt", "r").each_line do |line|
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

def has_corner(top, left, diagonal)
  if (!top && !left)
    # puts "                         yes! case 1"
    return true
  end
  if (top && left && !diagonal)
    # puts "                         yes! case 2"
    return true
  end
  # puts "                         nope"
  false
end

def calc_corners(current_walked, height, width, table)
  ans = 0
  (0...height).each do |i|
    # puts "#{i} of #{height}"
    (0...width).each do |j|
      next unless current_walked[i][j]

      top =  i > 0 ? current_walked[i-1][j] : nil
      top_right =  (i > 0 && j < width - 1) ? current_walked[i-1][j+1] : nil
      right = j < width - 1 ? current_walked[i][j+1] : nil
      bottom_right = (i < height - 1 && j < width - 1) ? current_walked[i+1][j+1] : nil
      bottom =  i < height - 1 ? current_walked[i+1][j] : nil
      bottom_left = (i < height - 1 && j > 0) ? current_walked[i+1][j-1] : nil
      left = j > 0 ? current_walked[i][j-1] : nil
      top_left = (i > 0 && j > 0) ? current_walked[i-1][j-1] : nil

      # puts " ########## top left"
      ans += 1 if has_corner(top, left, top_left)
      # puts " ########## right top"
      ans += 1 if has_corner(right, top, top_right)
      # puts " ########## bottom right"
      ans += 1 if has_corner(bottom, right, bottom_right)
      # puts " ########## left bottom"
      ans += 1 if has_corner(left, bottom, bottom_left)

      # puts "#{i}-#{j} has #{ans} corners"
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
    # puts " --- #{table[i][j]}"
    area = walk(i, j, table, $walked, height, width, table[i][j], current_walked)
    # current_walked.each do |row|
    #   puts "#{row.inspect}"
    # end
    corners = calc_corners(current_walked, height, width, table)
    # puts " >>>> #{corners} corners, #{area} area"
    sides = corners
    ans += (area * sides)
  end
end

puts "ANSWER: #{ans}"
