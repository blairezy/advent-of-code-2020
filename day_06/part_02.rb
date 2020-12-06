def get_input()
  input = IO.readlines("input.txt", chomp: true)
end

def get_total(input)
  return input[0].length if input.length == 1

  new_array = []
  input.each_with_index do | array, index |
    new_array = array if index == 0
    new_array &= array
  end

  new_array.length
end

input = get_input()

answers = []
total = 0

input.each_with_index do |line, index|
  answers << line.split("") unless line.strip.empty?

  if line.strip.empty? || index == input.length-1
    total += get_total(answers)
    answers = []
    next
  end
end

puts total
# answer 3360