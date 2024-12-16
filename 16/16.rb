# part 1

# maze = []
# values = []
#
# File.readlines("./input.txt").each do |line|
#   maze << line.chop.split('')
#   values << Array.new(line.chop.length).map { |i| -1 }
# end
#
# def find_char(maze, char)
#   maze.each_with_index do |row, i|
#     row.each_with_index do |cell, j|
#       return i, j if cell == char
#     end
#   end
# end
#
# i, j = find_char(maze, 'S')
# queue = ["#{i}-#{j}-E-0"]
# hash = {}
#
# while queue.any?
#   str = queue.shift
#   next if hash[str]
#   hash[str] = true
#
#   item = str.split('-')
#   # puts "#{item.inspect}"
#   current_i = item[0].to_i
#   current_j = item[1].to_i
#   dir = item[2]
#   check_value = item[3].to_i
#
#   if values[current_i][current_j] == -1 || check_value < values[current_i][current_j]
#     values[current_i][current_j] = check_value
#     current_value = values[current_i][current_j]
#     # puts "> cur val #{current_value}"
#
#     if dir != 'N' && maze[current_i + 1][current_j] != '#'
#       next_value = current_value + 1
#       next_value += 1000 if dir != 'S'
#       queue << "#{current_i + 1}-#{current_j}-S-#{next_value}"
#       # puts ">> pushing #{current_i+1}-#{current_j}-S-#{next_value}"
#     end
#
#     if dir != 'S' && maze[current_i - 1][current_j] != '#'
#       next_value = current_value + 1
#       next_value += 1000 if dir != 'N'
#       queue << "#{current_i - 1}-#{current_j}-N-#{next_value}"
#       # puts ">> pushing #{current_i-1}-#{current_j}-N-#{next_value}"
#     end
#
#     if dir != 'E' && maze[current_i][current_j - 1] != '#'
#       next_value = current_value + 1
#       next_value += 1000 if dir != 'W'
#       queue << "#{current_i}-#{current_j - 1}-W-#{next_value}"
#       # puts ">> pushing #{current_i}-#{current_j-1}-W-#{next_value}"
#     end
#
#     if dir != 'W' && maze[current_i][current_j + 1] != '#'
#       next_value = current_value + 1
#       next_value += 1000 if dir != 'E'
#       queue << "#{current_i}-#{current_j + 1}-E-#{next_value}"
#       # puts ">> pushing #{current_i}-#{current_j+1}-E-#{next_value}"
#     end
#   end
#
#   # values.each do |row|
#   #   puts row.map{ |cell| cell.to_s.ljust(5) }.join
#   # end
# end
#
# # maze.each do |row|
# #   puts row.join('')
# # end
#
# # values.each do |row|
#   # puts row.map { |cell| cell.to_s.ljust(5) }.join
#   # puts row.inspect
# # end
#
# # hash.entries.each do |entry|
# #   puts entry
# # end
#
# end_i, end_j = find_char(maze, 'E')
#
# puts "ANSWER: #{values[end_i][end_j]}"

maze = []
values = []
good_spots = []
possible_values = []

File.readlines("./test-2-input.txt").each do |line|
  maze << line.chop.split('')
  values << Array.new(line.chop.length).map { |i| -1 }
  good_spots << Array.new(line.chop.length).map { |i| false }
  possible_values << Array.new(line.chop.length).map { |i| [] }
end

def find_char(maze, char)
  maze.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      return i, j if cell == char
    end
  end
end

i, j = find_char(maze, 'S')
queue = ["#{i}-#{j}-E-0"]
hash = {}

while queue.any?
  str = queue.shift
  next if hash[str]
  hash[str] = true

  item = str.split('-')
  # puts "#{item.inspect}"
  current_i = item[0].to_i
  current_j = item[1].to_i
  dir = item[2]
  check_value = item[3].to_i

  possible_values[current_i][current_j] << check_value

  if values[current_i][current_j] == -1 || check_value <= values[current_i][current_j]
    values[current_i][current_j] = check_value
    current_value = values[current_i][current_j]
    # puts "> cur val #{current_value}"

    if dir != 'N' && maze[current_i + 1][current_j] != '#'
      next_value = current_value + 1
      next_value += 1000 if dir != 'S'
      queue << "#{current_i + 1}-#{current_j}-S-#{next_value}"
      # puts ">> pushing #{current_i+1}-#{current_j}-S-#{next_value}"
    end

    if dir != 'S' && maze[current_i - 1][current_j] != '#'
      next_value = current_value + 1
      next_value += 1000 if dir != 'N'
      queue << "#{current_i - 1}-#{current_j}-N-#{next_value}"
      # puts ">> pushing #{current_i-1}-#{current_j}-N-#{next_value}"
    end

    if dir != 'E' && maze[current_i][current_j - 1] != '#'
      next_value = current_value + 1
      next_value += 1000 if dir != 'W'
      queue << "#{current_i}-#{current_j - 1}-W-#{next_value}"
      # puts ">> pushing #{current_i}-#{current_j-1}-W-#{next_value}"
    end

    if dir != 'W' && maze[current_i][current_j + 1] != '#'
      next_value = current_value + 1
      next_value += 1000 if dir != 'E'
      queue << "#{current_i}-#{current_j + 1}-E-#{next_value}"
      # puts ">> pushing #{current_i}-#{current_j+1}-E-#{next_value}"
    end
  end
end

# maze.each do |row|
#   puts row.join('')
# end

values.each do |row|
  puts row.map { |cell| cell.to_s.ljust(6) }.join
  # puts row.inspect
end

end_i, end_j = find_char(maze, 'E')
good_spots[end_i][end_j] = true
queue2 = ["#{end_i}-#{end_j}-#{values[end_i][end_j]}"]
while queue2.any?
  str = queue2.shift
  item = str.split('-')
  current_i = item[0].to_i
  current_j = item[1].to_i
  value = item[2].to_i

  if !good_spots[current_i - 1][current_j] && values[current_i - 1][current_j] != -1
    if (values[current_i - 1][current_j] == value - 1)
      good_spots[current_i - 1][current_j] = true
      queue2 = ["#{current_i - 1}-#{current_j}-#{value - 1}"]
    end
    if (values[current_i - 1][current_j] == value - 1001)
      good_spots[current_i - 1][current_j] = true
      queue2 = ["#{current_i - 1}-#{current_j}-#{value - 1001}"]
    end
  end

  if !good_spots[current_i + 1][current_j] && values[current_i + 1][current_j] != -1
    if (values[current_i + 1][current_j] == value - 1)
      good_spots[current_i + 1][current_j] = true
      queue2 = ["#{current_i + 1}-#{current_j}-#{value - 1}"]
    end
    if (values[current_i + 1][current_j] == value - 1001)
      good_spots[current_i + 1][current_j] = true
      queue2 = ["#{current_i + 1}-#{current_j}-#{value - 1001}"]
    end
  end

  if !good_spots[current_i][current_j - 1] && values[current_i][current_j - 1] != -1
    if (values[current_i][current_j - 1] == value - 1)
      good_spots[current_i][current_j - 1] = true
      queue2 = ["#{current_i}-#{current_j - 1}-#{value - 1}"]
    end
    if (values[current_i][current_j - 1] == value - 1001)
      good_spots[current_i][current_j - 1] = true
      queue2 = ["#{current_i}-#{current_j - 1}-#{value - 1001}"]
    end
  end

  if !good_spots[current_i][current_j + 1] && values[current_i][current_j + 1] != -1
    if (values[current_i][current_j + 1] == value - 1)
      good_spots[current_i][current_j + 1] = true
      queue2 = ["#{current_i}-#{current_j + 1}-#{value - 1}"]
    end
    if (values[current_i][current_j + 1] == value - 1001)
      good_spots[current_i][current_j + 1] = true
      queue2 = ["#{current_i}-#{current_j + 1}-#{value - 1001}"]
    end
  end
end

ans = 0
good_spots.each do |row|
  puts row.map { |cell| cell.to_s.ljust(6) }.join

  row.each do |cell|
    ans += 1 if cell
  end
end

puts "ANSWER: #{ans}"