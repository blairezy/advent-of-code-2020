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

def get_point(input)
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

    return first_point.value
  end
end

def get_invalid_set(input, value)
  index = 0

  while true
    set = []
    sum = 0
    list_to_iterate = input[index..-1]

    list_to_iterate.each do | point |
      unless set.nil?
        sum = set.sum
      end

      if sum + point.value < value
        set << point.value
      elsif sum + point.value == value
        set << point.value
        return set
      else
        set = []
        set << point.value
      end
    end
    index += 1
  end
end

def calculate_answer(set)
  set.sort!
  set[0] + set[-1]
end

input = initialize_input()
point = get_point(input)
invalid_set = get_invalid_set(input.get_list, point)
answer = calculate_answer(invalid_set)
puts answer
