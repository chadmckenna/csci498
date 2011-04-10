require 'JackTokenizer.rb'
require 'CompilationEngine.rb'

class JackAnalyzer
  def initialize(file)
    @input = File.open(file, 'r')
    @ouput = File.new(file.sub(/.jack/, "") + "T.mine.xml", "w")
    write_input
    #tokenize
  end
  
  def write_input
    @input.each_line { |line| puts line }
  end
  
  def tokenize
    # Tokenize code goes here
  end
  
end


# Driver Program
if ARGV.length != 1
  puts "The amount of arguments you have passed is incorrect."
  puts "Usage: ruby JackAnalyzer.rb /Directory/Or/Filename/Goes/Here"
else
  if File.directory?(ARGV[0])
    dir = Dir.open(ARGV[0])
    Dir.foreach(dir.path) do |file|
      if file =~ /.jack$/
        JackAnalyzer.new(ARGV[0]+file)
      end
    end
  else
    if ARGV[0] =~ /.jack$/
      JackAnalyzer.new(ARGV[0])
    else
      puts "Your input is wrong, bro. Try again next time."
      puts "Usage: ruby JackAnalyzer.rb /Directory/Or/Filename/Goes/Here"
    end
  end
end