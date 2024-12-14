# rules_done = false;
# rules = []
# all = []
# good_ones = []

# File.open("./05-input.txt", "r").each_line do |line|
#   if line == "\n"
#     rules_done = true
#     next
#   end

#   if rules_done
#     all << line.chop.split(',').map(&:to_i)
#   else
#     rules << line.chop.split('|').map(&:to_i)
#   end
# end

# all.each do |edit|
#   is_good = true
#   rules.each do |rule|
#     index_of_first = edit.find_index(rule[0])
#     index_of_second = edit.find_index(rule[1])

#     if (index_of_first && index_of_second && (index_of_first > index_of_second))
#       is_good = false
#     end
#   end

#   good_ones << edit if is_good
# end

# ans = good_ones.map{ |edit| edit[edit.length / 2] }.sum

# puts "ANSWER #{ans}"

rules_done = false;
$rules = []
all = []
bad_ones = []

File.open("./05-many-solutions.txt", "r").each_line do |line|
  if line == "\n"
    rules_done = true
    next
  end

  if rules_done
    all << line.chop.split(',').map(&:to_i)
  else
    $rules << line.chop.split('|').map(&:to_i)
  end
end

all.each do |edit|
  # puts "EDIT #{edit.inspect}"
  is_good = true
  $rules.each do |rule|
    index_of_first = edit.find_index(rule[0])
    index_of_second = edit.find_index(rule[1])
    if (index_of_first && index_of_second)
      # puts "- rule applies: #{rule.inspect}"
    end

    if (index_of_first && index_of_second && (index_of_first > index_of_second))
      is_good = false
      # puts "-- violation!: #{rule.inspect}"
    end
  end

  bad_ones << edit unless is_good
end

def find_violations(edit)
  violations = []
  $rules.each do |rule|
    index_of_first = edit.find_index(rule[0])
    index_of_second = edit.find_index(rule[1])

    if (index_of_first && index_of_second && (index_of_first > index_of_second))
      violations << rule
    end
  end
  # puts "> find_violations return: #{violations.inspect}"
  violations
end

bad_ones.each do |bad_edit|
  puts "BAD EDIT #{bad_edit.inspect}"

  while (violations = find_violations(bad_edit)) != []
    # fix first violation
    violation = violations.first
    puts "-- FIXING VIOLATION #{violation}"
    index_of_second = bad_edit.find_index(violation[1])
    bad_edit.delete(violation[0])
    bad_edit.insert(index_of_second, violation[0])

    puts "--- FIXED! EDIT IS NOW #{bad_edit.inspect}"
  end
end

ans = bad_ones.map{ |edit| edit[edit.length / 2] }.sum

puts "ANSWER #{ans}"
