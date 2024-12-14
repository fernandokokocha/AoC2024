# text = File.read('./03input.txt')

# sum = 0

# while mul = (/mul\((\d{1,3}),(\d{1,3})\)/).match(text)
#   sum += Integer($1) * Integer($2)
#   text = $'
# end

# puts "ANSWER #{sum}"

text = File.read('./03input.txt')

$regex_mul = /mul\((\d{1,3}),(\d{1,3})\)/
$regex_do = /do\(\)/
$regex_dont = /don\'t\(\)/

def match_all(text)
  closest = nil
  mul = ($regex_mul).match(text)
  return nil unless mul

  closest = mul
  enable = ($regex_do).match(text)
  if (enable && enable.pre_match.size < closest.pre_match.size)
    closest = enable
  end

  disable = ($regex_dont).match(text)
  if (disable && disable.pre_match.size < closest.pre_match.size)
    closest = disable
  end

  closest
end

sum = 0
enabled = true

while closest_match = match_all(text)
  case closest_match.regexp.object_id
  when $regex_mul.object_id
    sum += (Integer(closest_match[1]) * Integer(closest_match[2])) if enabled
  when $regex_do.object_id
    enabled = true
  when $regex_dont.object_id
    enabled = false
  end
  
  text = closest_match.post_match
end

puts "ANSWER #{sum}"
