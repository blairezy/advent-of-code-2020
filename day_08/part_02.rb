module Operation
  ACC = "acc"
  JMP = "jmp"
  NOP = "nop"
end

class Record
  def initialize(location, operation, sign, value)
    @location = location
    @operation = operation
    @sign = sign
    @value = value
  end

  def location
    @location
  end

  def operation
    @operation
  end

  def operation=(value)
    @operation = value
  end

  def sign
    @sign
  end

  def value
    @value
  end
end

@accumulator = 0
@position_counter = 0
@boot_code = []
is_repeating = false
@position_history = []
@changelog = []
is_running = true

def get_input()
  IO.readlines("input.txt", chomp: true)
end

def initialize_boot_code(input)
  code_list = []
  input.each_with_index do | command, index |
    op, signed_value = command.split
    sign = signed_value.chars[0]
    value = signed_value[1..].to_i
    code_list << Record.new(index, op, sign, value)
  end
  code_list
end

def update_boot_code
  @boot_code.each do | command |
    if command.operation == Operation::NOP && !@changelog.include?(command.location)
      command.operation = Operation::JMP
      @changelog << command.location
      return
    elsif command.operation == Operation::JMP && !@changelog.include?(command.location)
      command.operation = Operation::NOP
      @changelog << command.location
      return
    end
  end
end

def reset_boot_code
  command = @boot_code.find { |x| x.location == @changelog[-1] }

  if command.operation == Operation::NOP
    command.operation = Operation::JMP
  elsif command.operation == Operation::JMP
    command.operation = Operation::NOP
  end
end

@boot_code = initialize_boot_code(get_input)
while is_running
  update_boot_code()

  while !is_repeating
    if @position_history.include?(@position_counter)
      is_repeating = true
      next
    end

    @position_history << @position_counter

    command = @boot_code.find { |x| x.location == @position_counter }

    if command.nil?
      is_running = false
      next
    end

    case command.operation
    when Operation::ACC
      case command.sign
      when '+'
        @accumulator += command.value
      when '-'
        @accumulator -= command.value
      else
        puts "error"
      end
      @position_counter += 1
    when Operation::JMP
      case command.sign
      when '+'
        @position_counter += command.value
      when '-'
        @position_counter -= command.value
      else
        puts "error"
      end
    when Operation::NOP
      @position_counter +=1
    else
      puts "error"
    end
  end

  next if !is_running

  if is_repeating
    is_repeating = false
    @accumulator = 0
    @position_counter = 0
    @position_history = []
    reset_boot_code()
  end
end

puts @accumulator
#answer 640

