class Parser
  attr_reader :read_file
  
  # Reads a file into the parser
  def initialize(file)
    @read_file = file
  end
  
  # This functions looks to see if there are extra commands 
  # in the input. Returns boolean.
  def has_more_commands?
    
  end

  # This function reads the next line/command from the input 
  # file and sets it as our current working command.
  # Only called if has_more_commands? is true.
  def advance
    
  end
  
  # Returns teh type of the current command.
  # Return is either A_COMMAND, C_COMMAND, or L_COMMAND
  def command_type
    
  end
  
  # Returns the symbol or decimal Xxx of the current command.
  # @Xxx or (Xxx). Should be called only when command_type is
  # A_COMMAND or L_COMMAND
  def symbol
    
  end
  
  # Returns the dest mnemonic in the current C-command (8 
  # possibilities). Should be called only when command_type
  # is C_COMMAND. Returns a string.
  def dest
    
  end
  
  # Returns the comp mnemonic in the current C-command (28
  # possibilities). Should be called only when command_type
  # is C_COMMAND. Returns a string.
  def comp
    
  end
  
  # Returns the jump mnemonic in the current C-command (8 
  # possibilities). Should be called only when command_type
  # is C_COMMAND.
  def jump
    
  end
  
end