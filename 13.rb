# part 1

# def scan_numbers(string)
#   numbers = string.scan(/(\d+)/)
#   x = numbers[0][0].to_i
#   y = numbers[1][0].to_i
#   [x, y]
# end
#
# def calc_min_tokens(ax, ay, bx, by, result_x, result_y)
#   ret = 0
#
#   (0...100).each do |i|
#     result_ax = i * ax
#     result_ay = i * ay
#
#     break if (result_ax > result_x) or (result_ay > result_y)
#
#     (0...100).each do |j|
#       result_bx = j * bx
#       result_by = j * by
#
#       break if ((result_ax + result_bx) > result_x) or ((result_ay + result_by) > result_y)
#
#       if ((result_ax + result_bx) == result_x) && ((result_ay + result_by) == result_y)
#         tokens = 3 * i + j
#         ret = tokens if ((ret == 0) || (tokens < ret))
#       end
#     end
#   end
#
#   ret
# end
#
# ans = 0
#
# File.readlines("./13-input.txt").each_slice(4) do |slice|
#   ax, ay = scan_numbers(slice[0])
#   bx, by = scan_numbers(slice[1])
#   result_x, result_y = scan_numbers(slice[2])
#
#
#   min_tokens = calc_min_tokens(ax, ay, bx, by, result_x, result_y)
#   # puts "min tokens: #{min_tokens}"
#   ans += min_tokens
# end
#
# puts "ANSWER: #{ans}"

def scan_numbers(string)
  numbers = string.scan(/(\d+)/)
  x = numbers[0][0].to_i
  y = numbers[1][0].to_i
  [x, y]
end

def calc_min_tokens(ax, ay, bx, by, x, y)
  a = ((x * by) - (y * bx)) / ((ax * by) - (ay * bx))
  b = ((x * ay) - (y * ax)) / ((ax * by) - (ay * bx))

  # puts " #{ax} #{ay} #{bx} #{by} #{x} #{y}"
  # puts " solution: #{a} #{b}"

  return 0 if (ax * a - bx * b) != x
  return 0 if (ay * a - by * b) != y

  a*3 - b
end

ans = 0

File.readlines("./13-input.txt").each_slice(4) do |slice|
  ax, ay = scan_numbers(slice[0])
  bx, by = scan_numbers(slice[1])
  result_x, result_y = scan_numbers(slice[2])
  result_x += 10_000_000_000_000
  result_y += 10_000_000_000_000

  min_tokens = calc_min_tokens(ax, ay, bx, by, result_x, result_y)
  # puts "min tokens: #{min_tokens}"



  ans += min_tokens
end

puts "ANSWER: #{ans}"
