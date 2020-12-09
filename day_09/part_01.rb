class XmasValue
  def initialize(location, value)
    @location = location
    @value = value
  end

  def location
    @location
  end

  def value
    @value
  end
end

class XmasList
  def initialize(list)
    @list = list
  end

  def get_list
    @list
  end
end

def get_input()
  IO.readlines("input.txt", chomp: true)
end

def initialize_input()
  input = get_input
  temp_list = []
  input.each_with_index do |line, index|
    temp_list << XmasValue.new(index, line.to_i)
  end
  XmasList.new(temp_list)
end

input = initialize_input()

found = false
preamble = 25
list_index = 25
while !found
  first_point = input.get_list.find { |x| x.location == list_index}

  start_index = list_index - preamble
  list = input.get_list[start_index..(list_index-1)]

  sum_found = false
  list.each_with_index do | outer, outer_index |
    list.each_with_index do | inner, inner_index |
      next if outer_index == inner_index

      if outer.value + inner.value == first_point.value
        sum_found = true
        next
      end
    end
    next if sum_found
  end
  if sum_found
    list_index += 1
    next
  end

  puts first_point.value
  return
end