input = IO.readlines("input.txt")

valid_count = 0

input.each do |line|
  values = line.split(" ")
  minimum, maximum = values[0].split("-")
  letter = values[1].tr(':','')
  password = values[2]

  count = password.count(letter)

  if count >= minimum.to_i && count <= maximum.to_i
    valid_count += 1
  end
end

puts valid_count
# answer 414