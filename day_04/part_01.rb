def getInput()
  IO.readlines("input.txt")
end

@required_fields = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]

def parseInput(content)
  map = {}
  pairs = content.split(/[' ',\n]/)
  pairs.each do | pair |
    key, value = pair.split(":")
    map[key] = value
  end
  map
end

def validPassport?(passport)
  data = parseInput(passport)
  @required_fields - data.keys == []
end

input = getInput()

passport = ""
valid_count = 0

input.each_with_index do |line, index|
  passport << line unless line.strip.empty?

  if line.strip.empty? || index == input.length-1
    if validPassport?(passport)
      valid_count += 1
    end

    passport = ""
    next
  end
end

puts valid_count
#answer 204