class CompilationEngine
  def initialize(tokenizer)
    @tokenizer = tokenizer
  end
  
  def compile
    while (@tokenizer.has_more_tokens?)
      compile_next_token
    end
  end
  
  def compile_next_token
  	if(@tokenizer.has_more_tokens?)
    	@tokenizer.advance
	  end
#    token_type = @tokenizer.token_type
#  if token_type.eql?('KEYWORD')
#    key_word = @tokenizer.key_word
#    #@output.write("<keyword> " + key_word.downcase + " </keyword>\n")
#    if key_word.eql?('CLASS')
#      compile_class
#    elsif key_word.eql?('METHOD') or key_word.eql?('FUNCTION') or key_word.eql?('CONSTRUCTOR')
#      compile_subroutine
#    elsif (key_word.eql?('INT') or key_word.eql?('BOOLEAN') or key_word.eql?('BOOLEAN') or #y_word.eql?('CHAR') or key_word.eql?('VOID') 
#      or key_word.eql?('TRUE') or key_word.eql?('FALSE') or key_word.eql?('NULL') or #y_word.eql?('THIS'))
#      @output.write("<keyword> " + key_word.downcase + " </keyword>\n")
#    elsif key_word.eql?('VAR')
#      compile_var_dec
#    elsif key_word.eql?('STATIC') or key_word.eql?('FIELD')
#      compile_class_var_dec
#    elsif key_word.eql?('LET')
#      compile_let
#    elsif key_word.eql?('DO')
#      compile_do
#    elsif key_word.eql?('IF') or key_word.eql?('ELSE')
#      compile_if
#    elsif key_word.eql?('WHILE')
#      compile_while
#    elsif key_word.eql?('RETURN')
#      compile_return
#    else
#      puts 'Invalid keyword call.'
#    end
#  elsif token_type.eql?('SYMBOL')
#    symbol = @tokenizer.symbol
#    if (symbol.eql?('<'))
#      symbol = '&lt;'
#    elsif (symbol.eql?('>'))
#      symbol = '&gt;'
#    end
#    @output.write("<symbol> " + symbol + " </symbol>\n")
#  elsif token_type.eql?('IDENTIFIER')
#    identifier = @tokenizer.identifier
#    @output.write("<identifier> " + identifier + " </identifier>\n")
#  elsif token_type.eql?('INT_CONST')
#    int_val = @tokenizer.int_val
#    @output.write("<integerConstant> " + int_val + " </integerConstant>\n")
#  elsif token_type.eql?('STRING_CONST')
#    string_val = @tokenizer.string_val
#    string_val.gsub!(/&/, "&amp;")
#    string_val.gsub!(/\"/, "")
#    @output.write("<stringConstant> " + string_val + " </stringConstant>\n")
#  else
#    puts 'Invalid token call.'
#  end
  end
  
  def compile_class
    @output.write('<class>\n')
    
    compile_next_token
    
    if !@tokenizer.key_word.eql?("class")
    	puts "expected keyword class"
    	return    	
	end
	
	compile_next_token
	
	if !@tokenizer.token_type.eql?("IDENTIFIER")
		puts"expected class identifier"
		return
	end
	
	@output.write(@tokenizer.print_token)
	
	compile_next_token
	
	if !@tokenizer.symbol.token_type.eql?("{")
		puts"expected {"
		return
	end
	
	@output.write(@tokenizer.print_token)
	
	compile_next_token
	
	while (@tokenizer.key_word.eql?("STATIC") or @tokenizer.key_word.eql?("FIELD"))
		compile_class_var_dec
	end
	
	while (@tokenizer.key_word.eql?("CONSTRUCTOR") or @tokenizer.key_word.eql?("FUNCTION") or @tokenizer.key_word.eql?("METHOD"))
		compile_subroutine
	end
	
	if !(@tokenizer.symbol.eql("}"))
		puts"expected }"
		return
	end
	@output.write(@tokenizer.print_token)
	
	@output.write("</class>")
  end
  
  def compile_class_var_dec
    
  end
  
  def compile_subroutine
  end
  
  def compile_parameter_list
  end
  
  def compile_var_dec
  end
  
  def compile_statements
  end
  
  def compile_do
  end
  
  def compile_let
    @output.write("<letStatement>")
    
    @output.write("</letStatement>")
  end
  
  def compile_while
  end
  
  def compile_return
  end
  
  def compile_if
  end
  
  def compile_expression
  end
  
  def compile_term
  end
  
  def compile_expression_list
  end
end