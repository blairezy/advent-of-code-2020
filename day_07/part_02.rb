class Bag
  def initialize(color, count = 1)
  @color = color
  @count = count
  end

  def color
    @color
  end

  def count
    @count
  end
end

class Rule
  def initialize(bag, contains, list)
    @bag = bag
    @contains = contains
    @list_of_bags = list
  end

  def bag
    @bag
  end

  def contains
    @contains
  end

  def bags()
    @list_of_bags
  end

  def contains_bags?
    !@list_of_bags.empty?
  end
end


def get_input()
  IO.readlines("input.txt", chomp: true)
end

def initialize_rules(input)
  input.each do |rule|
    elements = rule.split(" bags contain ")

    sub_bag_list = []
    top_level_bag = nil
    contains = 0
    elements.each_with_index do | element, index |
      if index == 0
        top_level_bag = Bag.new(element)
        next
      end


      stripped_elements = element.split(/bags?[,|.]? ?/)
      stripped_elements.each do |sub_bag|
        next if sub_bag.include?("no")

        split_elements = sub_bag.split(" ")

        color = split_elements[1] + " " + split_elements[2]
        count = split_elements[0]

        contains += count.to_i

        sub_bag_list << Bag.new(color, count.to_i)
      end
    end
    # puts Rule.new(top_level_bag, contains, sub_bag_list).inspect
    @all_rules << Rule.new(top_level_bag, contains, sub_bag_list)
  end
end


def process_bags(rule)
  if !rule.contains_bags?
    return 0
  end

  count = 0
  rule.bags.each do | bag |
    new_bag_rule = @all_rules.find {|x| x.bag.color == bag.color}
    inside_count = process_bags(new_bag_rule)

    count += bag.count
    count += (bag.count * inside_count)
  end

  return count
end

@all_rules = []
initialize_rules(get_input())

rule = @all_rules.find {|x| x.bag.color == "shiny gold"}

inside = process_bags(rule)

puts inside
#answer 2431

