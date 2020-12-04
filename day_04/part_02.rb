def getInput()
  IO.readlines("input.txt")
end

BYR = "byr"
IYR = "iyr"
EYR = "eyr"
HGT = "hgt"
HCL = "hcl"
ECL = "ecl"
PID = "pid"

@required_fields = [BYR,IYR,EYR,HGT,HCL,ECL,PID]

def parseInput(content)
  map = {}
  pairs = content.split(/[' ',\n]/)
  pairs.each do | pair |
    key, value = pair.split(":")
    map[key] = value
  end
  map
end

def all_passport_data_present?(passport)
  data = parseInput(passport)
  @required_fields - data.keys == []
end

def is_4_digits?(value)
  value.digits.count == 4
end

def validate_byr(value)
  is_4_digits?(value) && value >= 1920 && value <= 2002
end

def validate_iyr(value)
  is_4_digits?(value) && value >= 2010 && value <= 2020
end

def validate_eyr(value)
  is_4_digits?(value) && value >= 2020 && value <= 2030
end

def validate_hgt(value)
  cm = value.slice!("cm")
  inches = value.slice!("in")

  unless cm.nil?
    return value.to_i >= 150 && value.to_i <= 193
  end

  unless inches.nil?
    return value.to_i >= 59 && value.to_i <= 76
  end

  false
end

def validate_hcl(value)
  return false unless value[0] == '#'

  value[0] = ''
  value.match(/[0-9a-f]{6}/) ? true : false
end

def validate_ecl(value)
  ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(value)
end

def validate_pid(value)
  value.length == 9
end

def all_passport_data_valid?(passport)
  data = parseInput(passport)

  return false unless validate_byr(data[BYR].to_i)
  return false unless validate_iyr(data[IYR].to_i)
  return false unless validate_eyr(data[EYR].to_i)
  return false unless validate_hgt(data[HGT])
  return false unless validate_hcl(data[HCL])
  return false unless validate_ecl(data[ECL])
  return false unless validate_pid(data[PID])
  true
end

input = getInput()

passport = ""
valid_count = 0

input.each_with_index do |line, index|
  passport << line unless line.strip.empty?

  if line.strip.empty? || index == input.length-1
    if all_passport_data_present?(passport) && all_passport_data_valid?(passport)
      valid_count += 1
    end

    passport = ""
    next
  end

end

puts valid_count
#answer 179