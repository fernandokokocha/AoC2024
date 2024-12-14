# part 1

# ans = 0

# def calc(numbers, permutation)
#   ret = numbers[0]
#   numbers.each_with_index do |n, i|
#     next if i == 0
#     if (permutation[i-1] == '+')
#       ret += numbers[i]
#     else
#       ret *= numbers[i]
#     end
#   end
#   ret
# end

# def can_be_done(x, numbers)
#   ['+', '*'].repeated_permutation(numbers.length - 1).each do |p|
#     return true if x == calc(numbers, p)
#   end

#   return false
# end

# File.open("./07-input.txt", "r").each_line do |line|
#   splited = line.split(':')
#   x = splited[0].to_i
#   numbers = splited[1].strip.split(' ').map(&:to_i)
  
#   ans += x if can_be_done(x, numbers)
# end

# puts "ANSWER: #{ans}"

# part 2

ans = 0

def calc(numbers, permutation)
  ret = numbers[0]
  numbers.each_with_index do |n, i|
    next if i == 0
    if (permutation[i-1] == '+')
      ret += numbers[i]
    elsif (permutation[i-1] == '*')
      ret *= numbers[i]
    else 
      ret = (ret.to_s + numbers[i].to_s).to_i
    end
  end
  ret
end

def can_be_done(x, numbers)
  ['+', '*', "|"].repeated_permutation(numbers.length - 1).each do |p|
    return true if x == calc(numbers, p)
  end

  return false
end

File.open("./07-input.txt", "r").each_line do |line|
  splited = line.split(':')
  x = splited[0].to_i
  numbers = splited[1].strip.split(' ').map(&:to_i)
  
  ans += x if can_be_done(x, numbers)
end

puts "ANSWER: #{ans}"