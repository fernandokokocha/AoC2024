# part 1

# def is_safe?(n)
#   inc = (n[1] - n[0]).positive?
#   (0...(n.size-1)).each do |i|
#     diff = n[i+1] - n[i] 
#     if inc
#       return false if diff < 1 || diff > 3
#     else
#       return false if diff < -3 || diff > -1
#     end
#   end

#   true
# end

# sum = 0

# while line=gets
#   n = line.split.map(&:to_i)
#   sum += 1 if is_safe?(n)
# end

# puts "ANSWER #{sum}"


def is_safe?(n)
  inc = (n[1] - n[0]).positive?
  (0...(n.size-1)).each do |i|
    diff = n[i+1] - n[i] 
    if inc
      return false if diff < 1 || diff > 3
    else
      return false if diff < -3 || diff > -1
    end
  end

  true
end

def can_be_safe?(n)
  n.each_with_index do |item, i|
    new_array = n.dup.tap{ |ncopy| ncopy.delete_at(i) }
    return true if is_safe?(new_array)
  end

  false
end

sum = 0

while line=gets
  n = line.split.map(&:to_i)
  sum += 1 if is_safe?(n) || can_be_safe?(n)
end


puts "ANSWER #{sum}"
 