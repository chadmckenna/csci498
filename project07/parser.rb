require 'yaml'

class Parser
  # Reads a file into the parser
  def initialize(file)
    @read_file = Array.new
    file.each_line do |line| 
      unless line.to_s.index(/\/\//).eql? nil
        line[line.to_s.index(/\/\//).to_i..line.to_s.length()] = ''
      end
      @read_file.push(line.strip)
    end
    @read_file.delete('')
    @current_line = 0
    @current_command = []
    @command = ''
    @arg1 = ''
    @arg2 = 0
  end
  
  # If necessary, we can reset and re-iterate over the document
  def reset
    @current_line = 0
    @skipped_line = 0
  end
  
  # Checks to see if there are more commands
  def has_more_commands?
    @current_line != @read_file.length
  end
  
  # Advances to the next line in the program
  def advance
    @current_line += 1
  end
  
  # Returns the command type of the given line
  def command_type
    @current_command.clear
    @current_command = @read_file.at(@current_line).split(" ")
    @command = @current_command[0]
  
    # Some implementation has been intentionally been left out at this point
    if @current_command[0].eql?('push')
      @arg1 = @current_command[1]
      @arg2 = @current_command[2]
      return 'C_PUSH'
    elsif @current_command[0].eql?('pop')
      @arg1 = @current_command[1]
      @arg2 = @current_command[2]
      return 'C_POP'
    else
      return 'C_ARITHMETIC'
    end
  end
  
  def get_command_arg
    return @command
  end
  
  # Returns the first argument of the current command
  def arg1
    return @arg1
  end
  
  # If there is an arg2, it returns it
  def arg2
    return @arg2
  end
end