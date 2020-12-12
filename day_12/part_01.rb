module Directions
  NORTH = "N"
  SOUTH = "S"
  EAST = "E"
  WEST = "W"
  FORWARD = "F"
  LEFT = "L"
  RIGHT = "R"
end

# should this class be responsible for parsing input
class Instruction
  def initialize(action, units)
    @action = action
    @units = units
  end

  def action
    @action
  end

  def units
    @units
  end
end

class Ship
  def initialize
    @position = [0,0]
    @facing = Directions::EAST
  end

  def position
    @position
  end

  def facing
    @facing
  end

  def apply_action(instruction)
    case instruction.action
      when Directions::NORTH
        move_north(instruction.units)
      when Directions::SOUTH
        move_south(instruction.units)
      when Directions::EAST
        move_east(instruction.units)
      when Directions::WEST
        move_west(instruction.units)
      when Directions::FORWARD
        move_forward(instruction.units)
      when Directions::LEFT
        turn_left(instruction.units)
      when Directions::RIGHT
        turn_right(instruction.units)
      end
  end

  private

  def move_north(units)
    @position[1] += units
  end

  def move_south(units)
    @position[1] -= units
  end

  def move_east(units)
    @position[0] += units
  end

  def move_west(units)
    @position[0] -= units
  end

  def move_forward(units)
    case facing
    when Directions::NORTH
      move_north(units)
    when Directions::SOUTH
      move_south(units)
    when Directions::EAST
      move_east(units)
    when Directions::WEST
      move_west(units)
    end
  end

  def turn_left(units)
    return if units == 0

    case facing
    when Directions::NORTH
      @facing = Directions::WEST
    when Directions::SOUTH
      @facing = Directions::EAST
    when Directions::EAST
      @facing = Directions::NORTH
    when Directions::WEST
      @facing = Directions::SOUTH
    end
    turn_left(units - 90)
  end

  def turn_right(units)
    return if units == 0

    case facing
    when Directions::NORTH
      @facing = Directions::EAST
    when Directions::SOUTH
      @facing = Directions::WEST
    when Directions::EAST
      @facing = Directions::SOUTH
    when Directions::WEST
      @facing = Directions::NORTH
    end
    turn_right(units - 90)
  end
end

class Navigate
  def perform()
    input = get_input
    instruction_list = initialize_instructions(input)

    #put instructions in ship
    ship = Ship.new
    follow_instructions(ship, instruction_list)

    manhattan_distance = calculate_manhattan_distance(ship.position)
    print manhattan_distance
  end

  private

  def get_input()
    IO.readlines("input.txt", chomp:true)
  end

  def parse_input(instruction)
    action = instruction.chars[0]
    unit = instruction[1..-1].to_i

    Instruction.new(action, unit)
  end

  def initialize_instructions(input)
    list = []
    input.each do |line|
      list << parse_input(line)
    end
    list
  end

  def follow_instructions(ship, instructions)
    instructions.each do |instruction|
      ship.apply_action(instruction)
    end
  end

  def calculate_manhattan_distance(position)
    position[0].abs + position[1].abs
  end
end

Navigate.new.perform