input = IO.readlines("input.txt")

valid_count = 0

input.each do |line|
  values = line.split(" ")
  first_index, second_index = values[0].split("-")
  letter = values[1].tr(':','')
  password = values[2]

  chopped = password[(first_index.to_i-1)...second_index.to_i]

  if chopped[0] == letter
    if chopped[-1] != letter
      valid_count += 1
    end
  elsif chopped[-1] == letter
    valid_count += 1
  end
end

puts valid_count
# answer 413