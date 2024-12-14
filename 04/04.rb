# # part 1

# rows = []
# width = 0
# height = 0

# while line=gets
#   rows << line.chop.chars
#   width = line.size
# end

# height = rows.size

# puts "#{width} x #{height}"

# rows << Array.new(width, [])
# rows << Array.new(width, [])
# rows << Array.new(width, [])

# sum = 0
# founds = []

# rows.each_with_index do |row, i|
#   row.each_with_index do |col, j|
#     next if rows[i][j] != 'X'
    
#     #up
#     founds << "#{i}x#{j} u" if ((i>2) && (rows[i-1][j] == 'M') && (rows[i-2][j] == 'A') && (rows[i-3][j] == 'S'))
#     #up-right
#     founds << "#{i}x#{j} ur" if ((i>2) && (j<width-3) && (rows[i-1][j+1] == 'M') && (rows[i-2][j+2] == 'A') && (rows[i-3][j+3] == 'S'))
#     #right
#     founds << "#{i}x#{j} r" if ((j<width-3) && (rows[i][j+1] == 'M') && (rows[i][j+2] == 'A') && (rows[i][j+3] == 'S'))
#     #down-right
#     founds << "#{i}x#{j} dr" if ((i<height-3) && (j<width-3) && (rows[i+1][j+1] == 'M') && (rows[i+2][j+2] == 'A') && (rows[i+3][j+3] == 'S'))
#     #down
#     founds << "#{i}x#{j} d" if ((i<height-3) && (rows[i+1][j] == 'M') && (rows[i+2][j] == 'A') && (rows[i+3][j] == 'S'))
#     #down-left
#     founds << "#{i}x#{j} dl" if ((i<height-3) && (j>2) && (rows[i+1][j-1] == 'M') && (rows[i+2][j-2] == 'A') && (rows[i+3][j-3] == 'S'))
#     #left
#     founds << "#{i}x#{j} l" if ((j>2) && (rows[i][j-1] == 'M') && (rows[i][j-2] == 'A') && (rows[i][j-3] == 'S'))
#     #up-left
#     founds << "#{i}x#{j} ul" if ((i>2) && (j>2) && (rows[i-1][j-1] == 'M') && (rows[i-2][j-2] == 'A') && (rows[i-3][j-3] == 'S'))
#   end
# end

# # puts founds
# puts "ANSWER #{founds.size}"

# part 2

rows = []
width = 0
height = 0

while line=gets
  rows << line.chop.chars
  width = line.size
end

height = rows.size

puts "#{width} x #{height}"

sum = 0
founds = []

rows.each_with_index do |row, i|
  row.each_with_index do |col, j|
    next if rows[i][j] != 'A'
    next if i == 0
    next if i == height-1
    next if j == 0
    next if j == width-1
    
    # forward forward
    founds << "#{i}x#{j}" if ((rows[i-1][j-1] == 'M') && (rows[i+1][j+1] == 'S') && (rows[i+1][j-1] == 'M') && (rows[i-1][j+1] == 'S'))
    # forward backward
    founds << "#{i}x#{j}" if ((rows[i-1][j-1] == 'M') && (rows[i+1][j+1] == 'S') && (rows[i+1][j-1] == 'S') && (rows[i-1][j+1] == 'M'))
    # backward forward
    founds << "#{i}x#{j}" if ((rows[i-1][j-1] == 'S') && (rows[i+1][j+1] == 'M') && (rows[i+1][j-1] == 'M') && (rows[i-1][j+1] == 'S'))
    # backward backward
    founds << "#{i}x#{j}" if ((rows[i-1][j-1] == 'S') && (rows[i+1][j+1] == 'M') && (rows[i+1][j-1] == 'S') && (rows[i-1][j+1] == 'M'))
  end
end

# puts founds
puts "ANSWER #{founds.size}"
