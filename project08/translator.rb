require 'parser.rb'
require 'code_writer.rb'

class Translator
  def initialize(file, location)
    dirname = File.expand_path(file[0]).split("/")
    output_file = dirname[dirname.length-2]
    @inputs = file
    if location =~ /.vm$/
      @output = File.new(location.gsub(/.vm$/, "") + ".asm", "w")
    else
      @output = File.new(location + output_file + ".asm", "w")
    end
    parse
  end
  
  def write_input
    @input.each_line { |line| puts line }
  end
  
  def parse
    writer = CodeWriter.new(@output)
    writer.write_init
    
    @inputs.each do |input|
      input_file = File.open(input, 'r')
      parser = Parser.new(input_file)
    
      while(parser.has_more_commands?)
        command_type = parser.command_type
        if command_type.eql?('C_ARITHMETIC')
          writer.write_arithmetic(parser.get_command_arg)
        elsif command_type.eql?('C_PUSH') or command_type.eql?('C_POP')
          writer.write_push_pop(command_type, parser.arg1, parser.arg2)
        elsif command_type.eql?('C_LABEL')
          writer.write_label(parser.arg1)
        elsif command_type.eql?('C_GOTO')
          writer.write_goto(parser.arg1)
        elsif command_type.eql?('C_IF')
          writer.write_if(parser.arg1)
        elsif command_type.eql?('C_FUNCTION')
          writer.write_function(parser.arg1, parser.arg2)
        elsif command_type.eql?('C_RETURN')
          writer.write_return
        elsif command_type.eql?('C_CALL')
          writer.write_call(parser.arg1, parser.arg2)
        else
          puts 'Invalid command call.'
        end
        parser.advance
      end
    end
  end
end

# Driver Program
if ARGV.length != 1
  puts "The amount of arguments you have passed is incorrect."
  puts "Usage: ruby translator.rb /Directory/Or/Filename/Goes/Here"
else
  directory = []
  if File.directory?(ARGV[0])
    dir = Dir.open(ARGV[0])
    Dir.foreach(dir.path) do |file|
      if file =~ /.vm$/
        directory << ARGV[0] + file
        Translator.new(directory, ARGV[0])
      end
    end
  else
    if ARGV[0] =~ /.vm$/
      directory << ARGV[0]
      Translator.new(directory, ARGV[0])
    else
      puts "Your input is wrong, bro. Try again next time."
      puts "Usage: ruby translator.rb /Directory/Or/Filename/Goes/Here" 
    end
  end
end