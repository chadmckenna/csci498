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
    @commands = YAML.load_file('commands.yml')
  end
  
  # Checks to see if there are more commands
  def has_more_commands?
    
  end
  
  # Advances to the next line in the program
  def advance
    
  end
  
  # Returns the command type of the given line
  def command_type?
    
  end
  
  # Returns the first argument of the current command
  def arg1
    
  end
  
  # If there is an arg2, it returns it
  def arg2
    
  end
end