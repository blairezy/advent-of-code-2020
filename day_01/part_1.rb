# TODOS
# write tests to refactor this with peace of mind
# steps:
# 1. Read an input
# 2. Try to find 2 numbers that sum to 2020
# 2a. find 2 different numbers
# 2b.

list = IO.readlines("./day_01/input.txt")

class Compute2020
  def perform(lines)
    product = 0
    lines.each_with_index do |first_number, first_index|
      lines.each_with_index do |second_number, second_index|
        next if first_index == second_index

        sum = first_number.strip.to_i + second_number.strip.to_i

        if sum == 2020
          product = first_number.strip.to_i * second_number.strip.to_i
        end
      end
    end

    return product
  end
end


puts Compute2020.new.perform(list)
#answer 482811