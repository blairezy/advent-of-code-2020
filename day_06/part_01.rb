def get_input()
  input = IO.readlines("input.txt", chomp: true)
end

def get_total(input)
  duplicates_removed = input.split("").uniq
  duplicates_removed.length
end

input = get_input()

answers = ""
total = 0

input.each_with_index do |line, index|
  answers << line unless line.strip.empty?
  if line.strip.empty? || index == input.length-1
    total += get_total(answers)

    answers = ""
    next
  end
end

puts total
# answer 6625