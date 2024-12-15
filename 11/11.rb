# part 1
#
# table = []
#
# File.open("./11-test-2-input.txt", "r").each_line do |line|
#   table = line.chop.split(" ").map(&:to_i)
# end
#
# 25.times do |n|
#   # puts "#{n}: #{table.inspect}"
#   new_table = []
#   table.each_with_index do |item, i|
#     if item == 0
#       new_table << 1
#       next
#     end
#
#     item_s = item.to_s
#     if item_s.length.even?
#       new_table << item_s[0, item_s.length / 2].to_i
#       new_table << item_s[item_s.length / 2, item_s.length / 2].to_i
#       next
#     end
#
#     new_table << item * 2024
#   end
#   table = new_table
# end
#
# puts "ANSWER: #{table.length}"

table = []
memo = {}
ans = 0

File.open("./11-input.txt", "r").each_line do |line|
  table = line.chop.split(" ").map(&:to_i)
end

BLINKS = 75

def calc(number, depth, memo)
  return 1 if depth == 0

  key = "#{number}-#{depth}"
  # puts key

  return memo[key] if memo[key]

  if number == 0
    ret = calc(1, depth-1, memo)
    memo[key] = ret
    return ret
  end

  item_s = number.to_s
  if item_s.length.even?
    num1 = item_s[0, item_s.length / 2].to_i
    num2 = item_s[item_s.length / 2, item_s.length / 2].to_i
    ret = calc(num1, depth-1, memo) + calc(num2, depth-1, memo)
    memo[key] = ret
    ret
  else
    num = number * 2024
    ret = calc(num, depth-1, memo)
    memo[key] = ret
    ret
  end
end

table.each do |item|
  ans += calc(item, BLINKS, memo)
end

puts "ANSWER: #{ans}"
