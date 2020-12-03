input = IO.readlines("input.txt")

TREE = "#"

slopes = {
  "1" => [1,1],
  "2" => [3,1],
  "3" => [5,1],
  "4" => [7,1],
  "5" => [1,2],
}

tree_product = 1

slopes.each do | slope, coordinates |
  tree_count = 0
  abs_pos_x = 0

  input.each_with_index do |line, index|
    next if index == 0
    next if index.odd? && coordinates[1] == 2

    abs_pos_x +=  coordinates[0]

    pos_x = abs_pos_x % (line.strip().length)

    if line[pos_x] == TREE
      tree_count += 1
    end
  end
  tree_product *= tree_count
end

puts tree_product
# answer 4385176320