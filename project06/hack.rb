# author: Chad McKenna
# HACK Assembler 

# Hack assembler class 
class Hack
  attr_reader :filename
  
  def initialize(filename)
    @filename = filename
    @input = File.open(filename, "r")
    @output = File.new(filename.sub(/.asm/, "") + ".hack", "w")
  end
  
  def write_to_output
    @input.each_line { |line| @output.puts line }
  end
  
  def close
    @input.close
    @output.close
  end
end

# Program control 

# Make sure we're reading a .asm file
if ARGV[0] =~ /.asm/
  # Make sure they're only specifying one argument
  unless ARGV.length == 1
    puts "Yo bro, you don't have the right amount of arguments."
    puts "Usage: ruby hack.rb InputFile.asm"
    exit
  end
  
  # Main control logic
  puts 'Compiling...'
  run = Hack.new(ARGV[0])

  run.write_to_output
  
  run.close
else 
  # Notification shown if not using .asm filetype
  puts "Hey man, you must specify a .asm filetype."
  puts "Usage: ruby hack.rb InputFile.asm"
end