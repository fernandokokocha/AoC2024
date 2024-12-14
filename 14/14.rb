# part 1

# def scan_numbers(string)
#   numbers = string.scan(/(-?\d+)/)
#   x = numbers[0][0].to_i
#   y = numbers[1][0].to_i
#   vx = numbers[2][0].to_i
#   vy = numbers[3][0].to_i
#   [x, y, vx, vy]
# end
#
# def calc_ans(robots, width, height)
#   q1 = 0
#   q2 = 0
#   q3 = 0
#   q4 = 0
#
#   robots.each_with_index do |row, i|
#     row.each_with_index do |cell, j|
#       next if i == height / 2
#       next if j == width / 2
#
#       q1 += cell if (i < height / 2 && j < width / 2)
#       q2 += cell if (i < height / 2 && j > width / 2)
#       q3 += cell if (i > height / 2 && j > width / 2)
#       q4 += cell if (i > height / 2 && j < width / 2)
#     end
#   end
#
#   [q1, q2, q3, q4]
# end
#
# width = 101 # 11 # 101
# height = 103 # 7 # 103
#
# robots = []
# height.times do |y|
#   robots << Array.new(width).map { |x| 0 }
# end
#
# File.readlines("./input.txt").each  do |line|
#   parsed = scan_numbers(line)
#   x_after_100 = (parsed[0] + 100*parsed[2]) % width
#   y_after_100 = (parsed[1] + 100*parsed[3]) % height
#   robots[y_after_100][x_after_100] += 1
# end
# #
# # robots.each do |row|
# #   puts row.inspect
# # end
#
# qs = calc_ans(robots, width, height)
# ans = qs[0] * qs[1] * qs[2] * qs[3]
# puts "ANSWER: #{ans}"

def scan_numbers(string)
  numbers = string.scan(/(-?\d+)/)
  x = numbers[0][0].to_i
  y = numbers[1][0].to_i
  vx = numbers[2][0].to_i
  vy = numbers[3][0].to_i
  [x, y, vx, vy]
end

width = 101 # 11 # 101
height = 103 # 7 # 103

robots = []

pic = []

height.times do |y|
  pic << Array.new(width).map { |x| ' ' }
end

pic_dump = Marshal.dump(pic)

File.readlines("./input.txt").each do |line|
  parsed = scan_numbers(line)
  robots << parsed
end

File.open("./output.txt", 'w') do |file|
  (0..10000).each do |i|
    pic = Marshal.load(pic_dump)

    robots.each do |robot|
      x = (robot[0] + i * robot[2]) % width
      y = (robot[1] + i * robot[3]) % height
      pic[y][x] = 'X'
    end

    puts "#{i}"

    file.write("\n#{i}\n")
    pic.each do |pic_row|
      file.write(pic_row.join(''))
      file.write("\n")
    end
  end

end

