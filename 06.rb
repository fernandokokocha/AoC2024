# $table = []
# $footprints = []
# $facing = nil
# $position = nil
# $directions = ['v', '<', '^', '>']
#
# File.open('./06-input.txt', 'r') do |file_handle|
#   file_handle.each_line do |line|
#     $table << line.chop.split('')
#     $footprints << Array.new(line.chop.length).map { |e| [] }
#
#     if (found = line.index('v'))
#       $facing = 0
#       $position = [$table.length - 1, found]
#       $footprints[$table.length - 1][found].push('v')
#     elsif (found = line.index('<'))
#       $facing = 1
#       $position = [$table.length - 1, found]
#       $footprints[$table.length - 1][found].push('<')
#     elsif (found = line.index('>'))
#       $facing = 3
#       $position = [$table.length - 1, found]
#       $footprints[$table.length - 1][found].push('>')
#     elsif (found = line.index('^'))
#       $facing = 2
#       $position = [$table.length - 1, found]
#       $footprints[$table.length - 1][found].push('^')
#     end
#   end
# end
#
# def what_is_faced?
#   # puts " position is #{$position.inspect}"
#   # puts "  $table[$position[0] + 1] #{$table[$position[0] + 1].inspect}"
#   # puts "  $table[$position[0] + 1][$position[1]] #{$table[$position[0] + 1][$position[1]].inspect}"
#
#   case $facing
#   when 0
#     return 'EOM' if $position[0] == $table.length - 1
#     return $table[$position[0] + 1][$position[1]]
#   when 1
#     return 'EOM' if $position[1] == 0
#     return $table[$position[0]][$position[1] - 1]
#   when 2
#     return 'EOM' if $position[0] == 0
#     return $table[$position[0] - 1][$position[1]]
#   when 3
#     return 'EOM' if $position[1] == $table[0].length - 1
#     return $table[$position[0]][$position[1] + 1]
#   end
# end
#
# def make_move
#   case $facing
#   when 0
#     $position[0] += 1
#   when 1
#     $position[1] -= 1
#   when 2
#     $position[0] -= 1
#   when 3
#     $position[1] += 1
#   end
# end
#
# while true
#   is_facing_end_of_map = what_is_faced?
#   # puts "Position is #{$position.inspect}"
#   # puts "Facing is #{$directions[$facing].inspect}"
#   # puts "I AM FACING #{is_facing_end_of_map.inspect}"
#   if is_facing_end_of_map == 'EOM'
#     break
#   end
#
#   if is_facing_end_of_map == '#'
#     $facing = ($facing + 1) % 4
#   else
#     make_move
#     fs = $footprints[$position[0]][$position[1]]
#     if fs.include?($directions[$facing])
#       break
#     else
#       fs << $directions[$facing]
#     end
#   end
# end
#
# # $table.each do |t|
# #   puts t.inspect
# # end
#
# $ans = 0
# $footprints.each do |f|
#   f.each do |f2|
#     # puts f2.inspect
#     $ans += 1 if f2.any?
#   end
# end
#
# puts "ANSWER: #{$ans}"

$table = []
$footprints = []
$facing = nil
$position = nil
$directions = ['v', '<', '^', '>']

File.open('./06-input.txt', 'r') do |file_handle|
  file_handle.each_line do |line|
    $table << line.chop.split('')
    $footprints << Array.new(line.chop.length).map { |e| [] }

    if (found = line.index('v'))
      $facing = 0
      $position = [$table.length - 1, found]
      $footprints[$table.length - 1][found].push('v')
    elsif (found = line.index('<'))
      $facing = 1
      $position = [$table.length - 1, found]
      $footprints[$table.length - 1][found].push('<')
    elsif (found = line.index('>'))
      $facing = 3
      $position = [$table.length - 1, found]
      $footprints[$table.length - 1][found].push('>')
    elsif (found = line.index('^'))
      $facing = 2
      $position = [$table.length - 1, found]
      $footprints[$table.length - 1][found].push('^')
    end
  end
end

def what_is_faced?(i, j, my_facing, my_position, my_footprints)
  # puts " position is #{$position.inspect}"
  # puts "  $table[$position[0] + 1] #{$table[$position[0] + 1].inspect}"
  # puts "  $table[$position[0] + 1][$position[1]] #{$table[$position[0] + 1][$position[1]].inspect}"

  case my_facing
  when 0
    return 'EOM' if my_position[0] == $table.length - 1
    return '#' if ((my_position[0] + 1 == i) && (my_position[1] == j))
    return $table[my_position[0] + 1][my_position[1]]
  when 1
    return 'EOM' if my_position[1] == 0
    return '#' if ((my_position[0] == i) && (my_position[1] - 1 == j))
    return $table[my_position[0]][my_position[1] - 1]
  when 2
    return 'EOM' if my_position[0] == 0
    return '#' if ((my_position[0] - 1 == i) && (my_position[1] == j))
    return $table[my_position[0] - 1][my_position[1]]
  when 3
    return 'EOM' if my_position[1] == $table[0].length - 1
    return '#' if ((my_position[0] == i) && (my_position[1] + 1 == j))
    return $table[my_position[0]][my_position[1] + 1]
  end
end

def make_move(i, j, my_facing, my_position, my_footprints)
  case my_facing
  when 0
    my_position[0] += 1
  when 1
    my_position[1] -= 1
  when 2
    my_position[0] -= 1
  when 3
    my_position[1] += 1
  end
end

def simulate(i, j, my_facing, my_position, my_footprints)
  while true
    is_facing_end_of_map = what_is_faced?(i, j, my_facing, my_position, my_footprints)
    # puts "Position is #{$position.inspect}"
    # puts "Facing is #{$directions[$facing].inspect}"
    # puts "I AM FACING #{is_facing_end_of_map.inspect}"
    if is_facing_end_of_map == 'EOM'
      return 0
    end

    if is_facing_end_of_map == '#'
      my_facing = (my_facing + 1) % 4
    else
      make_move(i, j, my_facing, my_position, my_footprints)
      fs = my_footprints[my_position[0]][my_position[1]]
      if fs.include?($directions[my_facing])
        return 1
      else
        fs << $directions[my_facing]
      end
    end
  end
end

$ans = 0
$footprint_dump = Marshal.dump($footprints)

puts "MAP IS #{$table.length}x#{$table[0].length}"

$table.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    next if i == $position[0] && j == $position[1]
    next if $table[$position[0]][$position[1]] == '#'

    footprints = Marshal.load($footprint_dump)
    puts "simulate for #{i} #{j}"
    $ans += simulate(i, j, $facing.dup, $position.dup, footprints)
  end
end

puts "ANSWER: #{$ans}"
