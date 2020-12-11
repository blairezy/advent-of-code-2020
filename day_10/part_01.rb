def get_input()
  IO.readlines("input.txt", chomp: true).map(&:to_i)
end

output_joltage_list = get_input()

output_joltage_list.sort!

count_1 = 0
count_3 = 1
last_value = 0
output_joltage_list.each do |current_value|
  difference = current_value - last_value

  if difference == 1
    count_1 += 1
  elsif difference == 3
    count_3 += 1
  end

  last_value = current_value
end

puts count_1 * count_3
#answer 2201