# part 1
#
# ans = 0
#
# board = []
# scan_board = true
#
# def print_board(board)
#   board.each do |row|
#     puts row.inspect
#   end
# end
#
# def find_robot(board)
#   board.each_with_index do |row, i|
#     row.each_with_index do |cell, j|
#       return [i, j] if cell == '@'
#     end
#   end
# end
#
# def make_move(move, board)
#   i, j = find_robot(board)
#   tmp_i = i
#   tmp_j = j
#   boxes_to_move = 0
#
#   case move
#   when '<'
#     while board[tmp_i][tmp_j - 1] == 'O'
#       tmp_j -= 1
#       boxes_to_move += 1
#     end
#
#     if board[tmp_i][tmp_j - 1] == '.'
#       boxes_to_move.times do |n|
#         board[tmp_i][tmp_j - 1 + n] = 'O'
#       end
#       board[i][j - 1] = '@'
#       board[i][j] = '.'
#     end
#   when '^'
#     while board[tmp_i - 1][tmp_j] == 'O'
#       tmp_i -= 1
#       boxes_to_move += 1
#     end
#
#     if board[tmp_i - 1][tmp_j] == '.'
#       boxes_to_move.times do |n|
#         board[tmp_i - 1 + n][tmp_j] = 'O'
#       end
#       board[i - 1][j] = '@'
#       board[i][j] = '.'
#     end
#   when '>'
#     while board[tmp_i][tmp_j + 1] == 'O'
#       tmp_j += 1
#       boxes_to_move += 1
#     end
#
#     if board[tmp_i][tmp_j + 1] == '.'
#
#       boxes_to_move.times do |n|
#         board[tmp_i][tmp_j + 1 - n] = 'O'
#       end
#       board[i][j + 1] = '@'
#       board[i][j] = '.'
#     end
#   when 'v'
#     while board[tmp_i + 1][tmp_j] == 'O'
#       tmp_i += 1
#       boxes_to_move += 1
#     end
#
#     if board[tmp_i + 1][tmp_j] == '.'
#       boxes_to_move.times do |n|
#         board[tmp_i + 1 - n][tmp_j] = 'O'
#       end
#       board[i + 1][j] = '@'
#       board[i][j] = '.'
#     end
#   end
# end
#
# File.readlines("./input.txt").each do |line|
#   if line == "\n"
#     scan_board = false
#   end
#
#   if scan_board
#     board << line.chop.chars
#   else
#     moves = line.chop.chars
#     moves.each do |move|
#
#       # puts "============="
#       # puts move
#       make_move(move, board)
#       # print_board(board)
#     end
#   end
# end
#
# def calc_ans(board)
#   ret = 0
#   board.each_with_index do |row, i|
#     row.each_with_index do |cell, j|
#       if cell == 'O'
#         ret += ((100 * i) + j)
#       end
#     end
#   end
#   ret
# end
#
# ans = calc_ans(board)
#
# puts "ANSWER: #{ans}"

board = []
scan_board = true

def print_board(board)
  board.each do |row|
    puts row.join('')
  end
end

def find_robot(board)
  board.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      return [i, j] if cell == '@'
    end
  end
end

def can_be_moved(board, boxes, direction, i, j)
  case direction
  when '^'
    return false if board[i - 1][j] == '#'
    boxes.each do |box|
      nums = box.split('-').take(2).map(&:to_i)
      return false if board[nums[0] - 1][nums[1]] == '#'
    end
    return true
  when 'v'
    return false if board[i + 1][j] == '#'
    boxes.each do |box|
      nums = box.split('-').take(2).map(&:to_i)
      return false if board[nums[0] + 1][nums[1]] == '#'
    end
    return true
  end
end

def do_move(board, boxes, direction, i, j)
  board[i][j] = '.'
  boxes.each do |box|
    nums = box.split('-').take(2).map(&:to_i)
    board[nums[0]][nums[1]] = '.'
  end

  case direction
  when '^'
    boxes.each do |box|
      decoded = box.split('-')
      nums = decoded.take(2).map(&:to_i)
      char = decoded[2]
      board[nums[0] - 1][nums[1]] = char
    end
    board[i - 1][j] = '@'
  when 'v'
    boxes.each do |box|
      decoded = box.split('-')
      nums = decoded.take(2).map(&:to_i)
      char = decoded[2]
      # puts " >>> #{nums.inspect} - #{char}"
      board[nums[0] + 1][nums[1]] = char
    end
    board[i + 1][j] = '@'
  end
end

def make_move(move, board)
  i, j = find_robot(board)
  tmp_i = i
  tmp_j = j
  boxes_to_move = 0
  # puts "making move #{move}"

  case move
  when '<'
    while board[tmp_i][tmp_j - 1] == '[' || board[tmp_i][tmp_j - 1] == ']'
      tmp_j -= 1
      boxes_to_move += 1
    end

    if board[tmp_i][tmp_j - 1] == '.'
      boxes_to_move.times do |n|
        board[tmp_i][tmp_j - 1 + n] = board[tmp_i][tmp_j + n]
      end
      board[i][j - 1] = '@'
      board[i][j] = '.'
    end
  when '^'
    to_check = ["#{tmp_i - 1}-#{tmp_j}"]
    boxes = []
    while to_check.any?
      checking = to_check.shift.split('-').map(&:to_i)
      if board[checking[0]][checking[1]] == '['
        boxes << "#{checking[0]}-#{checking[1]}-["
        boxes << "#{checking[0]}-#{checking[1] + 1}-]"
        to_check << "#{checking[0] - 1}-#{checking[1]}"
        to_check << "#{checking[0] - 1}-#{checking[1] + 1}"
      elsif board[checking[0]][checking[1]] == ']'
        boxes << "#{checking[0]}-#{checking[1] - 1}-["
        boxes << "#{checking[0]}-#{checking[1]}-]"
        to_check << "#{checking[0] - 1}-#{checking[1] - 1}"
        to_check << "#{checking[0] - 1}-#{checking[1]}"
      end
    end
    do_move(board, boxes, '^', i, j) if can_be_moved(board, boxes, '^', i, j)
  when '>'
    while board[tmp_i][tmp_j + 1] == '[' || board[tmp_i][tmp_j + 1] == ']'
      tmp_j += 1
      boxes_to_move += 1
    end

    if board[tmp_i][tmp_j + 1] == '.'
      boxes_to_move.times do |n|
        board[tmp_i][tmp_j + 1 - n] = board[tmp_i][tmp_j - n]
      end
      board[i][j + 1] = '@'
      board[i][j] = '.'
    end
  when 'v'
    to_check = ["#{tmp_i + 1}-#{tmp_j}"]
    # puts " >>> to check: #{to_check.inspect}"
    boxes = []
    while to_check.any?
      # puts " >>> witam "
      checking = to_check.shift.split('-').map(&:to_i)
      # puts " >>> checking #{checking}"
      if board[checking[0]][checking[1]] == '['
        boxes << "#{checking[0]}-#{checking[1]}-["
        boxes << "#{checking[0]}-#{checking[1] + 1}-]"
        to_check << "#{checking[0] + 1}-#{checking[1]}"
        to_check << "#{checking[0] + 1}-#{checking[1] + 1}"
      elsif board[checking[0]][checking[1]] == ']'
        boxes << "#{checking[0]}-#{checking[1] - 1}-["
        boxes << "#{checking[0]}-#{checking[1]}-]"
        to_check << "#{checking[0] + 1}-#{checking[1] - 1}"
        to_check << "#{checking[0] + 1}-#{checking[1]}"
      end
    end
    do_move(board, boxes, 'v', i, j) if can_be_moved(board, boxes, 'v', i, j)
  end
end

File.readlines("./input.txt").each do |line|
  if line == "\n"
    scan_board = false
  end

  if scan_board
    transformed_line = []
    line.chop.chars.each do |char|
      case char
      when '#'
        transformed_line << '#'
        transformed_line << '#'
      when 'O'
        transformed_line << '['
        transformed_line << ']'
      when '.'
        transformed_line << '.'
        transformed_line << '.'
      when '@'
        transformed_line << '@'
        transformed_line << '.'
      end
    end
    board << transformed_line
  else
    moves = line.chop.chars
    moves.each do |move|

      # puts "============="
      # puts move
      make_move(move, board)
      # print_board(board)
    end
  end
end

def calc_ans(board)
  ret = 0
  board.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if cell == '['
        ret += ((100 * i) + j)
      end
    end
  end
  ret
end

print_board(board)
ans = calc_ans(board)

puts "ANSWER: #{ans}"
