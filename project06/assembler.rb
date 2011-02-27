# author: Chad McKenna
# HACK Assembler 

require 'parser.rb'

# Hack assembler class 
class Assembler
  attr_reader :filename
  
  def initialize(filename)
    @filename = filename
    @input = File.open(filename, "r")
    @output = File.new(filename.sub(/.asm/, "") + ".mine" + ".hack", "w")
  end
  
  def write_to_output
    @input.each_line { |line| @output.puts line }
  end
  
  def assemble
    # This is the 1st pass parser
    
    parser = Parser.new(@input)
    while(parser.has_more_commands?)
      binary_command = nil.to_s
      command_type = parser.command_type
      if command_type.eql?('A_COMMAND')
        # A_COMMAND Logic
        binary_command += '0'
        binary_command += '%015b' % parser.symbol.to_s
      elsif command_type.eql?('L_COMMAND')
        # L_COMMAND Logic
        binary_command += '111'
        binary_command += parser.symbol.to_s
      elsif command_type.eql?('C_COMMAND')
        # C_COMMAND Logic
        binary_command += '111'
        dest = parser.dest
        comp = parser.comp
        jump = parser.jump
        binary_command += comp.to_s + dest.to_s + jump.to_s
      else
        binary_command = nil
      end
      if binary_command != nil
        @output.puts binary_command
      end
      parser.advance
    end
  end
  
  def close
    @input.close
    @output.close
  end
end




# Program control 

# Make sure we're reading a .asm file
if ARGV[0] =~ /.asm$/
  # Make sure they're only specifying one argument
  unless ARGV.length == 1
    puts "Yo bro, you don't have the right amount of arguments."
    puts "Usage: ruby hack.rb InputFile.asm"
    exit
  end
  
  # Main control logic
  puts 'Compiling...'
  assembler = Assembler.new(ARGV[0])

  assembler.assemble
  
  assembler.close
  
  puts 'Done.'
else 
  # Notification shown if not using .asm filetype
  puts "Hey man, you must specify a .asm filetype."
  puts "Usage: ruby hack.rb InputFile.asm"
end