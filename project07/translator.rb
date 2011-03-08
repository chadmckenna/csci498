require 'parser.rb'
require 'erb'

class Translator
  def initialize(file)
    @input = File.open(file, 'r')
    @output = File.new(file.sub(/.vm/, "") + ".mine" + ".asm", "w")
  end
  
  def write_input
    @input.each_line { |line| puts line }
  end
  
  def parse
    parser = Parser.new(@input)
    writer = CodeWriter.new(@output)
  end
end

# Driver Program
if ARGV.length != 1
  puts "The amount of arguments you have passed is incorrect."
  puts "Usage: ruby translator.rb /Directory/Or/Filename/Goes/Here"
else
  if File.directory?(ARGV[0])
    dir = Dir.open(ARGV[0])
    Dir.foreach(dir.path) do |file|
      if file =~ /.vm$/
        Translator.new(ARGV[0]+file)
      end
    end
  else
    if ARGV[0] =~ /.vm$/
      Translator.new(ARGV[0])
    else
      puts "Your input is wrong, bro. Try again next time."
      puts "Usage: ruby translator.rb /Directory/Or/Filename/Goes/Here" 
    end
  end
end