require 'rubygems'
require 'yaml'
require 'erb'

class CodeWriter
  def initialize(file)
    @output = file
    @templates = YAML.load_file('commands.yml')
    @counter = 0
    @function_counter = 0
    @class_counter = 0
  end
  
  # Probably won't be used, but we'll see
  def set_file_name
    
  end
  
  def inc_counter
    @counter += 1
  end
  
  def increment_function_counter
    @function_counter += 1
  end
  
  def increment_class_counter
    @class_counter += 1
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
    class_counter = @class_counter
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
  
  def write_init
    filename = @templates['init']['init']
    file = File.read(filename)
    template = ERB.new(file)
    completed_template = template.result(binding)
    @output.write(completed_template)
  end
  
  def write_label(label)
    counter = @counter
    filename = @templates['label']['label']
    file = File.read(filename)
    template = ERB.new(file)
    completed_template = template.result(binding)
    @output.write(completed_template)
    
    inc_counter
  end
  
  def write_goto(label)
    counter = @counter
    filename = @templates['goto']['goto']
    file = File.read(filename)
    template = ERB.new(file)
    completed_template = template.result(binding)
    @output.write(completed_template)
    
    inc_counter
  end
  
  def write_if(label)
    counter = @counter
    filename = @templates['if']['if']
    file = File.read(filename)
    template = ERB.new(file)
    completed_template = template.result(binding)
    @output.write(completed_template)
    
    inc_counter
  end
  
  def write_call(name, num_args)
    counter = @counter
    f_counter = @function_counter
    filename = @templates['call']['call']
    file = File.read(filename)
    template = ERB.new(file)
    completed_template = template.result(binding)
    @output.write(completed_template)
    
    inc_counter
    increment_function_counter
  end
  
  def write_return
    counter = @counter
    filename = @templates['return']['return']
    file = File.read(filename)
    template = ERB.new(file)
    completed_template = template.result(binding)
    @output.write(completed_template)
    
    inc_counter
  end
  
  def write_function(name, num_locals)
    counter = @counter
    filename = @templates['function']['function']
    file = File.read(filename)
    template = ERB.new(file)
    completed_template = template.result(binding)
    @output.write(completed_template)
    
    inc_counter
  end
end
