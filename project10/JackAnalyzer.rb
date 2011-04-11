require 'JackTokenizer.rb'
require 'CompilationEngine.rb'

class JackAnalyzer
  def initialize(file)
    @input = File.open(file, 'r')
    @ouput = File.new(file.sub(/.jack/, "") + "T.mine.xml", "w")
    #write_input
    tokenize
  end
  
  def write_input
    @input.each_line { |line| puts line }
  end
  
  def tokenize
    # Tokenize code goes here
    tokenizer = JackTokenizer.new(@input)
    compiler = CompilationEngine.new(@output)
    while (tokenizer.has_more_tokens?)
      token_type = tokenizer.token_type
      if token_type.eql?('KEYWORD')
        key_word = tokenizer.key_word
        if key_word.eql?('CLASS')
          # Do something in CompEngine
        elsif key_word.eql?('METHOD')
          # Do something in CompEngine
        elsif key_word.eql?('FUNCTION')
          # Do something in CompEngine
        elsif key_word.eql?('CONSTRUCTOR')  
          # Do something in CompEngine
        elsif key_word.eql?('INT')
          # Do something in CompEngine
        elsif key_word.eql?('BOOLEAN')
          # Do something in CompEngine
        elsif key_word.eql?('CHAR')
          # Do something in CompEngine
        elsif key_word.eql?('VOID')
          # Do something in CompEngine
        elsif key_word.eql?('VAR')
          # Do something in CompEngine
        elsif key_word.eql?('STATIC')
          # Do something in CompEngine
        elsif key_word.eql?('FIELD')
          # Do something in CompEngine
        elsif key_word.eql?('LET')
          # Do something in CompEngine
        elsif key_word.eql?('DO')
          # Do something in CompEngine
        elsif key_word.eql?('IF')
          # Do something in CompEngine
        elsif key_word.eql?('ELSE')
          # Do something in CompEngine
        elsif key_word.eql?('WHILE')
          # Do something in CompEngine
        elsif key_word.eql?('RETURN')
          # Do something in CompEngine
        elsif key_word.eql?('TRUE')
          # Do something in CompEngine
        elsif key_word.eql?('FALSE')
          # Do something in CompEngine
        elsif key_word.eql?('NULL')
          # Do something in CompEngine
        elsif key_word.eql?('THIS')
          # Do something in CompEngine
        else
          puts 'Invalid keyword call.'
        end
      elsif token_type.eql?('SYMBOL')
        symbol = tokenizer.symbol
        # Do something in CompEngine
      elsif token_type.eql?('IDENTIFIER')
        identifier = tokenizer.identifier
        # Do something in CompEngine
      elsif token_type.eql?('INT_CONST')
        int_val = tokenizer.int_val
        # Do something in CompEngine
      elsif token_type.eql?('STRING_CONST')
        string_val = tokenizer.string_val
        # Do something in CompEngine
      else
        puts 'Invalid token call.'
      end
      tokenizer.advance
    end
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