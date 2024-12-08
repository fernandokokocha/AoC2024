ans = 0

def can_be_done(x, numbers)
  len = numbers.length
  return (x == numbers[0]) if len == 1

  return true if can_be_done(x - numbers[len-1], numbers.take(len-1)) 
  return true if ((x.remainder(numbers[len-1]) == 0) && can_be_done(x / numbers[len-1], numbers.take(len-1)))    
  
  if (x.to_s.end_with?(numbers[len-1].to_s))
    remining_string = x.to_s.delete_suffix(numbers[len-1].to_s)
    return true if can_be_done(remining_string.to_i, numbers.take(len-1)) 
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