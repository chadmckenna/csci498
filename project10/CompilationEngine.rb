class CompilationEngine
  def initialize(tokenizer, output)
    @tokenizer = tokenizer
    @output = output
  end
  
  def compile
    compile_class
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
    @output.write('<class>' + "\n")
    
    compile_next_token
    
    if !@tokenizer.key_word.eql?("CLASS")
    	puts "expected keyword class"
    	return    	
	end
	@output.write(@tokenizer.print_token)
	compile_next_token

  	if !@tokenizer.token_type.eql?("IDENTIFIER")
  		puts"expected class identifier"
  		return
  	end

  	@output.write(@tokenizer.print_token)

  	compile_next_token

  	#if !@tokenizer.symbol.token_type.eql?("{")
  	#	puts"expected {"
  	#	return
  	#end
	  if !@tokenizer.symbol.eql?("{")
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

  	if !(@tokenizer.symbol.eql?("}"))
  		puts"expected }"
  		return
  	end
  	@output.write(@tokenizer.print_token)

	  @output.write("</class>" + "\n")
  end
  
  def compile_class_var_dec
    @output.write("<classVarDec>" + "\n")
    if !(@tokenizer.key_word.eql?("STATIC") or @tokenizer.key_word.eql?("FIELD"))
    	puts "expected static or field"
    	return
    end
    
    @output.write(@tokenizer.print_token)
    
    compile_next_token

	#check for identifier or keywords(int char boolean)
	@output.write(@tokenizer.print_token)

	compile_next_token
	#check for variable names(identifiers)
	@output.write(@tokenizer.print_token)
	compile_next_token

	while @tokenizer.symbol.eql?(",")
		@output.write(@tokenizer.print_token)
		compile_next_token
		#check for additional variables/identifiers
		@output.write(@tokenizer.print_token)
		compile_next_token
	end
	#check for ;
	@output.write(@tokenizer.print_token)
	compile_next_token
	@output.write("</classVarDec>" + "\n")
  end
  
  def compile_subroutine
  	@output.write("<subroutineDec>" + "\n")
	#error check for constructor, function, or method
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	#error check for return type
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	#error check for function identifier
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	#error check for "("
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	@output.write("<parameterList>" + "\n")
  	compile_parameter_list
  	@output.write("</parameterList>" + "\n")
  	
  	#error check for ")"
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	@output.write("<subroutineBody>" + "\n")
  	
  	#error check for "{"
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	puts @tokenizer.print_token + " ahah"
  	while @tokenizer.key_word.eql?("VAR")
  		puts "test"
  		compile_var_dec
  	end
  	
  	compile_statements
  	
  	#error check for "}"
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	@output.write("</subroutineBody>" + "\n")
  	@output.write("</subroutineDec>" + "\n")
  end
  
  def compile_parameter_list
  	#error check for parameter type
  	if !(@tokenizer.key_word.eql?("VOID") or @tokenizer.key_word.eql?("INT") or @tokenizer.key_word.eql?("CHAR") or @tokenizer.key_word.eql?("BOOLEAN"))
  		return
  	end
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	#error check for parameter name
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	#puts "here" + @tokenizer.current_token
  	while @tokenizer.symbol.eql?(",")
  		@output.write(@tokenizer.print_token)
  		compile_next_token
  		
  		#error check for parameter type
  		@output.write(@tokenizer.print_token)
  		compile_next_token
  
  		#error check for paramater name
  		@output.write(@tokenizer.print_token)
  		compile_next_token		
  	end
  end
  
  def compile_var_dec
  	@output.write("<varDec>" + "\n")
  	
  	#Var Keyword
  	@output.write(@tokenizer.print_token)
    compile_next_token
    
    #type
    @output.write(@tokenizer.print_token)
    compile_next_token
  	
    #name
    @output.write(@tokenizer.print_token)
    compile_next_token
    
    while @tokenizer.symbol.eql?(",")
    	#type
    	@output.write(@tokenizer.print_token)
    	compile_next_token
    	#name
    	@output.write(@tokenizer.print_token)
    	compile_next_token
    end
    #;
    @output.write(@tokenizer.print_token)
    compile_next_token
    
    @output.write("</varDec>" + "\n")
  end
  
  def compile_statements
    @output.write("<statements>\n")
      while (@tokenizer.key_word.eql?("LET") or @tokenizer.key_word.eql?("DO") or @tokenizer.key_word.eql?("IF") or @tokenizer.key_word.eql?("WHILE") or @tokenizer.key_word.eql?("RETURN"))
        compile_statement
      end
    @output.write("</statements>\n")
  end
  
  def compile_statement
    if @tokenizer.key_word.eql?("LET") 
      compile_let
    elsif @tokenizer.key_word.eql?("DO") 
      compile_do
    elsif @tokenizer.key_word.eql?("IF")
      compile_if
    elsif @tokenizer.key_word.eql?("WHILE") 
      compile_while
    elsif@tokenizer.key_word.eql?("RETURN")
      compile_return
    end
    compile_next_token
  end
  
  def compile_do
    @output.write("<doStatement>\n")
    # Keyword
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Identifier
    @output.write(@tokenizer.print_token)
    compile_next_token
    if (@tokenizer.symbol.eql?('.'))
      # Symbol '.'
      @output.write(@tokenizer.print_token)
      compile_next_token
      # Identifier
      @output.write(@tokenizer.print_token)
      compile_next_token
      # Symbol '('
      @output.write(@tokenizer.print_token)
    else
      # Symbol '('
      @output.write(@tokenizer.print_token)
    end
    compile_next_token
    
    compile_expression_list
    
    # Symbol ')'
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Symbol ';'
    @output.write(@tokenizer.print_token)
    
    @output.write("</doStatement>\n")
  end
  
  def compile_let
    @output.write("<letStatement>\n")
    # Keyword
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Identifier
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Symbol
    if @tokenizer.symbol.eql?("[")
    	#[
    	@output.write(@tokenizer.print_token)
    	compile_next_token
    	compile_expression
    	#]
    	@output.write(@tokenizer.print_token)
    	compile_next_token
    end
    #=
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Will need extra implementation here, but this is ok for expressionless
    compile_expression
    compile_next_token
    @output.write(@tokenizer.print_token)
    #compile_next_token
    @output.write("</letStatement>\n")
  end
  
  def compile_while
    @output.write("<whileStatement>\n")
    #while
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Symbol '('
    @output.write(@tokenizer.print_token)
    compile_next_token
    compile_expression
    compile_next_token
    # Symbol ')'
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Symbol '{'
    @output.write(@tokenizer.print_token)
    compile_next_token
    compile_statements
    # Symbol '}'
    @output.write(@tokenizer.print_token)
    #compile_next_token
    @output.write("</whileStatement>\n")
  end
  
  def compile_return
  	@output.write("<returnStatement>" + "\n")
  	
  	#error check for return
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	if !@tokenizer.symbol.eql?(";")
  		compile_expression
  		compile_next_token
  	end
  	
  	#error check for ";"
  	@output.write(@tokenizer.print_token)
  	
  	@output.write("</returnStatement>" + "\n")  	
  	
  end
  
  def compile_if
  	@output.write("<ifStatement>" + "\n")
  	
  	#error check for if
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	#error check for "("
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	compile_expression
  	compile_next_token
  	
  	#error check for ")"
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	#error check for "{"
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	compile_statements
  	
  	#error check for "}"
  	@output.write(@tokenizer.print_token)
  	#compile_next_token
  	
  	if @tokenizer.key_word.eql?("ELSE")
  		@output.write(@tokenizer.print_token)
  		compile_next_token
  		compile_statements
  		
  		@output.write(@tokenizer.print_token)
  		#compile_next_token
  	end
  	@output.write("</ifStatement>" + "\n")
  end
  
  def compile_expression
    @output.write("<expression>\n")
    compile_term
    while (@tokenizer.symbol.eql?("+") or @tokenizer.symbol.eql?("-") or @tokenizer.symbol.eql?("*") or @tokenizer.symbol.eql?("/") or @tokenizer.symbol.eql?("&") or @tokenizer.symbol.eql?("|") or @tokenizer.symbol.eql?("<") or @tokenizer.symbol.eql?(">") or @tokenizer.symbol.eql?("="))
    	@output.write(@tokenizer.print_token)
    	compile_next_token
    	compile_term
    end
    @output.write("</expression>\n")
  end
  
  def compile_term
    @output.write("<term>\n")
    @output.write(@tokenizer.print_token)
    #compile_next_token
    @output.write("</term>\n")
  end
  
  def compile_expression_list
    @output.write("<expressionList>\n")
    while !@tokenizer.symbol.eql?(')')
      compile_expression
      compile_next_token
      # Symbol ','
      if @tokenizer.symbol.eql?(",")
        @output.write(@tokenizer.print_token)
        compile_next_token
      end
    end
    @output.write("</expressionList>\n")
  end

end