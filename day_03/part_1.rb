input = IO.readlines("input.txt")

TREE = "#"

tree_count = 0
abs_pos_x = 0

input.each_with_index do |line, index|
  next if index == 0

  abs_pos_x +=  3

  pos_x = abs_pos_x % (line.strip().length)

  if line[pos_x] == TREE
    tree_count += 1
  end
end

puts tree_count
# answer 173