require 'JackTokenizer.rb'
require 'CompilationEngine.rb'
require 'VMWriter.rb'

class JackAnalyzer
  def initialize(file)
    @input = File.open(file, 'r')
    @output = File.new(file.sub(/.jack/, "") + ".mine.xml", "w")
    @vm_output = File.new(file.sub(/.jack/, "") + ".vm", "w")
    #write_input
    tokenize
  end
  
  def write_input
    @input.each_line { |line| puts line }
  end
  
  def tokenize
    # Tokenize code goes here
    tokenizer = JackTokenizer.new(@input)
    #vmWriter = VMWriter.new(@vmOutput)
    comp_engine = CompilationEngine.new(tokenizer, @vm_output, @output)
    #compiler = CompilationEngine.new(@output)
    comp_engine.compile
    
    @input.close
    @output.close
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
        JackAnalyzer.new(ARGV[0]+ file)
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