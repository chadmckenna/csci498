require 'code.rb'

class Parser
  # Reads a file into the parser
  def initialize(file)
    @read_file = Array.new
    file.each_line { |line| @read_file.push(line) }
    @current_line = 0
  end
  
  def get_current_line
    @read_file.at(@current_line)
  end
  
  # This functions looks to see if there are extra commands 
  # in the input. Returns boolean.
  def has_more_commands?
    @current_line != (@read_file.length)
  end

  # This function reads the next line/command from the input 
  # file and sets it as our current working command.
  # Only called if has_more_commands? is true.
  def advance
    if has_more_commands?
      @current_line += 1
      if @read_file.at(@current_line) =~ /\/\//
        advance
      end
    end
  end
  
  # Returns teh type of the current command.
  # Return is either A_COMMAND, C_COMMAND, or L_COMMAND
  def command_type
    if @read_file.at(@current_line) =~ /^@/
      'A_COMMAND'
    elsif @read_file.at(@current_line) =~ /\(|\)/
      'L_COMMAND'
    elsif @read_file.at(@current_line) =~ /(=|;)/
      'C_COMMAND'
    else
      nil
    end
  end
  
  # Returns the symbol or decimal Xxx of the current command.
  # @Xxx or (Xxx). Should be called only when command_type is
  # A_COMMAND or L_COMMAND
  def symbol
    if command_type.eql?('A_COMMAND')
      @read_file.at(@current_line).gsub('@', '').strip
    elsif command_type.eql?('L_COMMAND')
      @read_file.at(@current_line).gsub('(', '').gsub(')', '').strip
    end
  end
  
  # Returns the dest mnemonic in the current C-command (8 
  # possibilities). Should be called only when command_type
  # is C_COMMAND. Returns a string.
  def dest
    if @read_file.at(@current_line) =~ /;/
      Code.dest('null')
    else
      Code.dest(@read_file.at(@current_line).split('=').at(0).strip)
    end
  end
  
  # Returns the comp mnemonic in the current C-command (28
  # possibilities). Should be called only when command_type
  # is C_COMMAND. Returns a string.
  def comp
    if @read_file.at(@current_line) =~ /;/
      Code.comp(@read_file.at(@current_line).split(';').at(0).strip)
    else
      Code.comp(@read_file.at(@current_line).split('=').at(1).strip)
    end
  end
  
  # Returns the jump mnemonic in the current C-command (8 
  # possibilities). Should be called only when command_type
  # is C_COMMAND.
  def jump
    if @read_file.at(@current_line) =~ /;/
      Code.jump(@read_file.at(@current_line).split(';').at(1).strip)
    else
      Code.jump('null')
    end
  end
  
end