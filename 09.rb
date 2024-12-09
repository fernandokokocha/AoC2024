# part 1

# def calc(memory)
#   while true 
#     index_of_last_number = memory.rindex { |n| n != nil }
#     index_of_first_free_space = memory.index { |n| n == nil }

#     puts "#{index_of_first_free_space} - #{index_of_last_number}"

#     return if index_of_first_free_space > index_of_last_number
#     memory[index_of_first_free_space], memory[index_of_last_number] = memory[index_of_last_number], memory[index_of_first_free_space]
#   end
# end

# def checksum(memory)
#   ans = 0
#   memory.each_with_index do |item, i|
#     return ans unless item
#     ans += item * i
#   end
# end

# File.open("./09-input.txt", "r").each_line do |line|
#   memory = []
#   index = 0
#   line.chop.chars.each_slice(2).with_index do |(file, free), i|
#     file.to_i.times { |n| memory << index }
#     index += 1
#     free.to_i.times { |n| memory << nil }
#   end
  
#   calc(memory)

#   puts "ANSWER: #{checksum(memory)}"
# end

def find_free(memory, size, max_index)
  (0..(max_index - size)).each do |i|
    return i if (i..(i+size-1)).all? { |current_i| memory[current_i].nil? }
  end
  
  return nil
end

def swap(memory, index1, index2, size)
  (0..size-1).each do |i|
    memory[index1+i], memory[index2+i] = memory[index2+i], memory[index1+i]
  end
end

def calc(memory)
  index = memory.length - 1
  while index >= 0
    puts "index: #{index}"
    item = memory[index]
    if item.nil?
      index -=1
    else
      index_of_free = find_free(memory, item[1], index)
      swap(memory, index_of_free, index - item[1] + 1, item[1]) unless index_of_free.nil?
        
      index -= item[1]
    end
  end
end

def checksum(memory)
  ans = 0
  memory.each_with_index do |item, i|
    next unless item
    ans += item[0] * i
  end
  ans
end

File.open("./09-input.txt", "r").each_line do |line|
  memory = []
  index = 0
  line.chop.chars.each_slice(2).with_index do |(file, free), i|
    file.to_i.times { |n| memory << [index, file.to_i] }
    index += 1
    free.to_i.times { |n| memory << nil }
  end
  
  calc(memory)

  puts "ANSWER: #{checksum(memory)}"
end