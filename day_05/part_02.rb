ALL_ROWS = (0..127).to_a
ALL_COLUMNS = (0..7).to_a

def get_input()
  input = IO.readlines("input.txt", chomp: true)
end

def get_row_data(input)
  input[0..6]
end

def get_column_data(input)
  input.chars.last(3).join
end

def get_position(input, seats)
  if seats.length == 1
    return seats[0].to_i
  end

  loc = input.slice!(0)

  if loc == "F" || loc == "L"
    reduced_rows = seats.each_slice( (seats.size/2.0).round ).to_a[0]
    get_position(input, reduced_rows)
  else
    reduced_rows = seats.each_slice( (seats.size/2.0).round ).to_a[1]
    get_position(input, reduced_rows)
  end
end

def get_seat_id(row, column)
  row * 8 + column
end

def get_my_seat_id(all_seat_ids)
  all_seat_ids.sort!

  first_id = 0
  second_id = 0

  all_seat_ids.each do |id|
    if first_id == 0
      first_id = id
      next
    end

    second_id = id

    if second_id - 2 == first_id
      return second_id - 1
    else
      first_id = second_id
    end
  end
end

input = get_input()
my_seat_id = 0
seat_ids = []
input.each do | pass |
  row_location = get_row_data(pass)
  column_location = get_column_data(pass)

  row = get_position(row_location, ALL_ROWS)
  column = get_position(column_location, ALL_COLUMNS)

  seat_ids << get_seat_id(row, column)
end

puts get_my_seat_id(seat_ids)
# answer 548