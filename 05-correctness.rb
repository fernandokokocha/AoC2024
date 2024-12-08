rules_done = false;
$rules = []

def find_violations(edit)
  violations = []
  $rules.each do |rule|
    index_of_first = edit.find_index(rule[0])
    index_of_second = edit.find_index(rule[1])

    if (index_of_first && index_of_second && (index_of_first > index_of_second))
      violations << rule
    end
  end
  violations
end

File.open("./05-input.txt", "r").each_line do |line|
  if line == "\n"
    rules_done = true
    next
  end

  if rules_done
    edit = line.chop.split(',').map(&:to_i)
    good_perms = []
    edit.permutation.each do |p|
      violations = find_violations(p)
      good_perms << p if violations.empty?
      puts "  #{p.inspect}: #{violations.length} violations (total #{good_perms.length} good perms)"
    end

    puts "EDIT #{edit.inspect}: #{good_perms.length} good perms"
    puts ""
  else
    $rules << line.chop.split('|').map(&:to_i)
  end
end
