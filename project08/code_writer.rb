require 'rubygems'
require 'yaml'
require 'erb'

class CodeWriter
  def initialize(file)
    @output = file
    @templates = YAML.load_file('commands.yml')
    @counter = 0
  end
  
  # Probably won't be used, but we'll see
  def set_file_name
    
  end
  
  def inc_counter
    @counter += 1
  end
  
  def write_arithmetic(command)
    counter = @counter
    filename = @templates['arithmetic'][command]
    file = File.read(filename)
    template = ERB.new(file)
    completed_template = template.result(binding)
    @output.write(completed_template)
    
    inc_counter
  end
  
  def write_push_pop(command, segment, index)
    counter = @counter
    if command.eql?('C_PUSH')
      filename = @templates['push'][segment]
    elsif command.eql?('C_POP')
      filename = @templates['pop'][segment]
    elsif command.eql?('C_FUNCTION')
      #to be implemented
    elsif command.eql?('C_CALL')
      #to be implemented
    end
    file = File.read(filename)
    template = ERB.new(file)
    completed_template = template.result(binding)
    @output.write(completed_template)
    
    inc_counter
  end
end
