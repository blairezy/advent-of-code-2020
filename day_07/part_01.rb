def get_input()
  IO.readlines("input.txt", chomp: true)
end

# def process_bags(input, bags)
#   if bags.length == 0
#     @new_bags_found = false
#     return
#   end

#   new_colored_bags = []
#   bags.each do |bag|
#     input.each do |rule|
#       if rule[bag] && rule.index(bag) != 0
#         new_colored_bags << rule[0..rule.index(" bags")].chomp
#       end
#     end
#   end

#   bags_duplicates_removed = new_colored_bags - (new_colored_bags & @all_colored_bags)

#   @all_colored_bags |= new_colored_bags
#   process_bags(input, bags_duplicates_removed)
# end

def process_bags(input, bags)
  if bags.length == 0
    @new_bags_found = false
    return
  end

  new_colored_bags = []
  bags.each do |bag|
    input.each do |rule|
      new_bag = rule[0..rule.index(" bags")].chomp(" ")
      if rule[bag] && rule.index(bag) != 0 && !@all_colored_bags.include?(new_bag)
        new_colored_bags << new_bag
        @all_colored_bags << new_bag
      end
    end
  end

  process_bags(input, new_colored_bags)
end

input = get_input()

@new_bags_found = true
@all_colored_bags = []

input.each do |rule|
  if rule["shiny gold"] && rule.index("shiny gold") != 0
    @all_colored_bags << rule[0..rule.index(" bags")].chomp(" ")
  end
end

while @new_bags_found
  process_bags(input, @all_colored_bags)
end

puts @all_colored_bags.length