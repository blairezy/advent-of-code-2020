product = nil;
list = IO.readlines("input.txt")

list.each_with_index do |first_number, first_index|
  list.each_with_index do |second_number, second_index|
    list.each_with_index do |third_number, third_index|
      next if first_index == second_index && second_index == third_index

      sum = first_number.strip.to_i + second_number.strip.to_i + third_number.strip.to_i

      if sum == 2020
        product = first_number.strip.to_i * second_number.strip.to_i * third_number.strip.to_i
      end
    end
  end
end

puts product
#answer 193171814