# app/models/chandrayaan.rb
class Chandrayaan
  attr_accessor :position, :direction

  def initialize(initial_position, initial_direction)
    @position = initial_position
    @direction = initial_direction
  end

  def move(distance)
    case @direction
    when 'N'
      @position[1] += distance
    when 'S'
      @position[1] -= distance
    when 'E'
      @position[0] += distance
    when 'W'
      @position[0] -= distance
    when 'U'
      @position[2] += distance
    when 'D'
      @position[2] -= distance
    end
  end

  def turn(direction)
    if @direction == 'U'
      case direction
      when 'l'
        @direction = 'N'
      when 'r'
        @direction = 'S'
      end
    elsif @direction == 'D'
      case direction
      when 'l'
        @direction = 'S'
      when 'r'
        @direction = 'N'
      end
    else
      directions = ['N', 'E', 'S', 'W']
      current_index = directions.index(@direction)

      case direction
      when 'l'
        new_index = (current_index - 1) % 4
      when 'r'
        new_index = (current_index + 1) % 4
      else
        return
      end

      @direction = directions[new_index]
    end
  end

  def tilt(direction)
    case direction
    when 'u'
      @direction = 'U'
    when 'd'
      @direction = 'D'
    end
  end

  def execute_commands(commands)
    validate_initial_direction

    commands.each do |command|
      if validate_command(command)
        case command
        when 'f', 'b'
          distance = (command == 'f') ? 1 : -1
          move(distance)
        when 'l', 'r'
          turn(command)
        when 'u', 'd'
          tilt(command)
        end
      else
        puts "Invalid command #{command}"
        puts "Enter a valid command"
        puts "----------------------- Exiting -------------------------"
        break
      end
    end
  end

  def final_state
    { position: @position, direction: @direction }
  end

  private

  def validate_initial_direction
    return if ['N', 'S', 'E', 'W', 'U', 'D'].include?(@direction)

    puts "Invalid direction #{@direction}"
    puts "Enter a valid direction"
    puts "----------------------- Exiting -------------------------"
    abort
  end

  def validate_command(command)
    if ['l', 'r', 'u', 'd', 'f', 'b'].include?(command)
      true
    else
      false
    end
  end
end
