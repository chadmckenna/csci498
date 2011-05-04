require 'VMWriter.rb'
require 'SymbolTable.rb'
class CompilationEngine
  def initialize(tokenizer, vm_output, output)
    @tokenizer = tokenizer
    @output = output
    @vm_writer = VMWriter.new(vm_output)
    @symbol_table = SymbolTable.new
    @label_num = 0
  end
  
  def compile
    compile_class
  end
  
  def compile_next_token
  	if(@tokenizer.has_more_tokens?)
    	@tokenizer.advance
	  end
  end
  
  def compile_class
    @output.write('<class>' + "\n")
    
    compile_next_token
    
    if !@tokenizer.key_word.eql?("CLASS")
    	puts "expected keyword class"
    	return    	
	  end
	  #class keyword
	  @output.write(@tokenizer.print_token)
	  compile_next_token

  	if !@tokenizer.token_type.eql?("IDENTIFIER")
  		puts"expected class identifier"
  		return
  	end
    #class identifier
  	@output.write(@tokenizer.print_token)
	  @class_name = @tokenizer.identifier
  	compile_next_token

	  if !@tokenizer.symbol.eql?("{")
  		puts"expected {"
  		return
  	end
    #{
  	@output.write(@tokenizer.print_token)

  	compile_next_token
    @num_fields = 0
  	while (@tokenizer.key_word.eql?("STATIC") or @tokenizer.key_word.eql?("FIELD"))
  		if @tokenizer.key_word.eql?("FIELD")
  			@num_fields += 1
  		end
  		compile_class_var_dec
  	end

  	while (@tokenizer.key_word.eql?("CONSTRUCTOR") or @tokenizer.key_word.eql?("FUNCTION") or @tokenizer.key_word.eql?("METHOD"))
  		compile_subroutine
  	end

  	if !(@tokenizer.symbol.eql?("}"))
  		puts"expected }"
  		return
  	end
  	#}
  	@output.write(@tokenizer.print_token)

	  @output.write("</class>" + "\n")
  end
  
  def compile_class_var_dec
    @output.write("<classVarDec>" + "\n")
    if !(@tokenizer.key_word.eql?("STATIC") or @tokenizer.key_word.eql?("FIELD"))
    	puts "expected static or field"
    	return
    elsif @tokenizer.key_work.eql?("STATIC")
    	@kind = "static"
    else
    	@kind = "field"
    end
    
    #static or field
    @output.write(@tokenizer.print_token)
    
    compile_next_token

	  #check for identifier or keywords(int char boolean)
	  @output.write(@tokenizer.print_token)
    
    if @tokenizer.token_type.eql?("KEYWORD")
    	@ident_type = @tokenizer.key_word
	  else
  		@ident_type = @tokenizer.identifier
  	end
	
  	compile_next_token
  	vars = array.new
  	#check for variable names(identifiers)
  	@output.write(@tokenizer.print_token)
  	vars.push(@tokenizer.identifier)
  	compile_next_token

  	while @tokenizer.symbol.eql?(",")
  		#,
  		@output.write(@tokenizer.print_token)
  		compile_next_token
  		#check for additional variables/identifiers
  		@output.write(@tokenizer.print_token)
  		vars.push(@tokenizer.identifier)
  		if @kind == "field"
  			@num_fields += 1
  		end
  		compile_next_token
  	end
  	#check for ;
  	@output.write(@tokenizer.print_token)
  	vars.each do |var|
  		@symbol_table.define(var, @ident_type, @kind)
  	end
  	compile_next_token
  	@output.write("</classVarDec>" + "\n")
  end
  
  def compile_subroutine
  	@is_constructor = false
  	@is_method = false
  	@num_locals = 0
  	@symbol_table.start_subroutine()
  	@output.write("<subroutineDec>" + "\n")
	#constructor, function, or method
  	@output.write(@tokenizer.print_token)
  	if @tokenizer.key_word.eql?("CONSTRUCTOR")
  		@is_constructor = true
  	elsif @tokenizer.key_word.eql?("METHOD")
  		@is_method = true
  	end
  	compile_next_token
  	
  	#return type
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	#function identifier
  	@output.write(@tokenizer.print_token)
  	@sub_name = @tokenizer.identifier
  	compile_next_token
  	
  	#"("
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	@output.write("<parameterList>" + "\n")
  	compile_parameter_list
  	@output.write("</parameterList>" + "\n")
  	
  	#")"
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	@output.write("<subroutineBody>" + "\n")
  	
  	#"{"
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	while @tokenizer.key_word.eql?("VAR")
  		compile_var_dec
  	end
  	
  	@vm_writer.write_function(@class_name + "." + @sub_name, @num_locals)
  	if @is_constructor
  		@vm_writer.write_push("constant", @num_fields)
  		@vm_writer.write_call("Memory.alloc", 1)
  		@vm_writer.write_pop("pointer", 0)
  	elsif @is_method
  		@vm_writer.write_push("arguement", 0)
  		@vm_writer.write_pop("pointer", 0)
  	end
  	compile_statements
  	
  	#"}"
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	@output.write("</subroutineBody>" + "\n")
  	@output.write("</subroutineDec>" + "\n")
  end
  
  def compile_parameter_list
  	#parameter type
  	if !(@tokenizer.key_word.eql?("VOID") or @tokenizer.key_word.eql?("INT") or @tokenizer.key_word.eql?("CHAR") or @tokenizer.key_word.eql?("BOOLEAN"))
  		return
  	end
  	@output.write(@tokenizer.print_token)
  	@argument_type = @tokenizer.key_word
  	compile_next_token
  	#parameter name
  	@output.write(@tokenizer.print_token)
  	@argument = @tokenizer.identifier
  	@symbol_table.define(@argument, @argument_type, "argument" )
  	compile_next_token
  	#puts "here" + @tokenizer.current_token
  	while @tokenizer.symbol.eql?(",")
  		@output.write(@tokenizer.print_token)
  		compile_next_token
  		
  		#parameter type
  		@output.write(@tokenizer.print_token)
  		@argument_type = @tokenizer.key_word
  		compile_next_token
  
  		#paramater name
  		@output.write(@tokenizer.print_token)
  		@argument = @tokenizer.identifier
  		@symbol_table.define(@argument, @argument_type, "argument" )
  		compile_next_token		
  	end
  end
  
  def compile_var_dec
  	@num_locals += 1
  	vars = Array.new
  	@output.write("<varDec>" + "\n")
  	
  	#Var Keyword
  	@output.write(@tokenizer.print_token)
    compile_next_token
    
    #type
    @output.write(@tokenizer.print_token)
 	 if @tokenizer.token_type.eql?("KEYWORD")
    	@ident_type = @tokenizer.key_word
	else
		@ident_type = @tokenizer.identifier
	end
    compile_next_token
  	
    #name
    @output.write(@tokenizer.print_token)
	  vars.push(@tokenizer.identifier)
    compile_next_token
    
    while @tokenizer.symbol.eql?(",")
    	#,
    	@output.write(@tokenizer.print_token)
    	compile_next_token
    	#name
    	@output.write(@tokenizer.print_token)
    	vars.push(@tokenizer.identifier)
    	compile_next_token
    	@num_locals += 1
    end
    #;
    @output.write(@tokenizer.print_token)
    vars.each do |var|
		@symbol_table.define(var, @ident_type, "local")
	end
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
  	identifier_one = ""
  	identifier_two = ""
    @output.write("<doStatement>\n")
    # Keyword do
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Identifier
    @output.write(@tokenizer.print_token)
    identifier_one = @tokenizer.identifier    
    compile_next_token
    if (@tokenizer.symbol.eql?('.'))
      # Symbol '.'
      @output.write(@tokenizer.print_token)
      compile_next_token
      # Identifier
      @output.write(@tokenizer.print_token)
      identifier_two = @tokenizer.identifier
      compile_next_token
      # Symbol '('
      @output.write(@tokenizer.print_token)
    else
      # Symbol '('
      @output.write(@tokenizer.print_token)
    end
    compile_next_token
 	if identifier_two.eql?("")
 		@vm_writer.write_push("pointer", 0)
 	else
 		@vm_writer.write_push(@symbol_table.kind_of(identifier_one), @symbol_table.index_of(identifier_one))
 	end
    compile_expression_list
    
    # Symbol ')'
    @output.write(@tokenizer.print_token)
    compile_next_token
    
    if(identifier_two.eql?(""))
    	@num_expressions += 1
    	call_name = @class_name + "." + indentifier_one
    else
    	if @symbol_table.has?("@identifier_one")
    		@num_expressions += 1
    		call_name = @symbol_table.type_of(indentifier_one) + "." + @identifier_two
    	else
    		call_name = identifier_one + "." + identifier_two
    	end
    end
    @vm_writer.write_call(call_name, @num_expressions)	
    @vm_writer.write_pop("temp", 0)
    # Symbol ';'
    @output.write(@tokenizer.print_token)
    
    @output.write("</doStatement>\n")
  end
  
  def compile_let
  	is_array = false
    @output.write("<letStatement>\n")
    # Keyword let
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Identifier
    @output.write(@tokenizer.print_token)
    var = @tokenizer.identifier
    compile_next_token
    # Symbol
    if @tokenizer.symbol.eql?("[")
    	is_array = true
    	#[
    	@output.write(@tokenizer.print_token)
    	kind = @symbol_table.kind_of(var)
    	@vm_writer.write_push(kind, @symbol_table.index_of(var))
    	compile_next_token
    	compile_expression
    	#]
    	@output.write(@tokenizer.print_token)
    	@vm_writer.write_arithmetic("add")
    	segment = "that"
    	index = 0
    	compile_next_token
    else
    	kind = @symbol_table.kind_of(var)
    	segment = kind
    	index = @symbol_table.index_of(var)
    end
    #=
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Will need extra implementation here, but this is ok for expressionless
    compile_expression
    if is_array
    	@vm_writer.write_pop("temp", 0)
    	@vm_writer.write_pop("pointer", 1)
    	@vm_writer.write_push("temp", 0)
    end
    @vm_writer.write_pop(segment, index)
    #compile_next_token
    @output.write(@tokenizer.print_token)
    #compile_next_token
    @output.write("</letStatement>\n")
  end
  
  def compile_while
  	@label_num += 1
  	label_one = "WHILE" + @label_num.to_s
  	@label_num += 1
  	label_two = "WHILE" + @label_num.to_s
  	
    @output.write("<whileStatement>\n")
    #while
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Symbol '('
    @output.write(@tokenizer.print_token)
    @vm_writer.write_label(label_one)
    compile_next_token
    compile_expression
    @vm_writer.write_arithmetic("not")
    @vm_writer.write_label(label_two)
    #compile_next_token
    # Symbol ')'
    @output.write(@tokenizer.print_token)
    compile_next_token
    # Symbol '{'
    @output.write(@tokenizer.print_token)
    compile_next_token
    compile_statements
    @vm_writer.write_goto(label_one)
    # Symbol '}'
    @output.write(@tokenizer.print_token)
    @vm_writer.write_goto(label_two)
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
  		#compile_next_token
  	else
  		@vm_writer.write_push("constant", 0)
	end
  	
  	#error check for ";"
  	@output.write(@tokenizer.print_token)
  	@vm_writer.write_return
  	@output.write("</returnStatement>" + "\n")  	
  	
  end
  
  def compile_if
  	if_true = "IF-TRUE" + @label_num
  	if_false = "IF-FAlSE" + @label_num
  	if_end = "IF-END" + @label_num
  	@label_num += 1
  	@output.write("<ifStatement>" + "\n")
  	
  	#if
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	#"("
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	compile_expression
  	#compile_next_token
  	
  	#")"
  	@output.write(@tokenizer.print_token)
  	@vm_writer.write_if(if_true)
  	@vm_writer.write_goto(if_false)
  	@vm_writer.write_label(if_true)
  	compile_next_token
  	
  	#"{"
  	@output.write(@tokenizer.print_token)
  	compile_next_token
  	
  	compile_statements
  	
  	#"}"
  	@output.write(@tokenizer.print_token)
  	#compile_next_token
  	
  	if @tokenizer.key_word.eql?("ELSE")
  		@vm_writer.write_goto(if_end)
  		@vm_writer.write_label(if_false)
  		#else
  		@output.write(@tokenizer.print_token)
  		compile_next_token
  		compile_statements
  		
  		@output.write(@tokenizer.print_token)
  		#compile_next_token
  		@vm_writer.write_label(if_end)
  	else
  		@vm_writer.write_label(if_false)
  	end
  	@output.write("</ifStatement>" + "\n")
  end
  
  def compile_expression
  	operators = Hash["+", "add", "-", "sub", "&", "and", "|", "or", "<", "lt", ">", "gt", "=", "eql"]
    @output.write("<expression>\n")
    compile_term
    while (@tokenizer.symbol.eql?("+") or @tokenizer.symbol.eql?("-") or @tokenizer.symbol.eql?("*") or @tokenizer.symbol.eql?("/") or @tokenizer.symbol.eql?("&") or @tokenizer.symbol.eql?("|") or @tokenizer.symbol.eql?("<") or @tokenizer.symbol.eql?(">") or @tokenizer.symbol.eql?("="))
    	#symbol
    	@output.write(@tokenizer.print_token)
    	operator = @tokenizer.symbol
    	compile_next_token
    	compile_term
    	if !(operator.eql?("*") or operator.eql?("/")
    		@vm_writer.write_arithmetic(operators[operator]))
    	elsif operator.eql?("*")
	    	@vm_writer.write_call("Math.multiply", 2)
	    elsif operator.eql?("/")
	    	@vm_writer.write_call("Math.divide", 2)
	    end
    end
    @output.write("</expression>\n")
  end
  
  def compile_term
    advance = false
  	@output.write("<term>\n")
    if @tokenizer.token_type.eql?("STRING_CONST") or @tokenizer.token_type.eql?("INT_CONST") or @tokenizer.token_type.eql?("KEYWORD")
    	@output.write(@tokenizer.print_token)
    	advance = true
    elsif @tokenizer.symbol.eql?("(")
    	#(
    	@output.write(@tokenizer.print_token)
    	compile_next_token
    	compile_expression
    	#)
    	@output.write(@tokenizer.print_token)
    	advance = true
    elsif @tokenizer.symbol.eql?("~") or @tokenizer.symbol.eql?("-")
    	#~ or -
    	@output.write(@tokenizer.print_token)
    	compile_next_token
    	compile_term
	  elsif @tokenizer.token_type.eql?("IDENTIFIER")
    	@output.write(@tokenizer.print_token)
    	compile_next_token
    	if @tokenizer.symbol.eql?("[")
    		#[
    		@output.write(@tokenizer.print_token)
    		compile_next_token
    		compile_expression
    		#]
    		@output.write(@tokenizer.print_token)
    		advance = true
      elsif @tokenizer.symbol.eql?("(")
      	#(
      	@output.write(@tokenizer.print_token)
  		  compile_next_token
		    compile_expression_list
		    compile_next_token
		    #)
		    @output.write(@tokenizer.print_token)
		    advance = true
	    elsif @tokenizer.symbol.eql?(".")
    	  #.
    	  @output.write(@tokenizer.print_token)
    	  compile_next_token
    	  #identifier
    	  @output.write(@tokenizer.print_token)
    	  compile_next_token
    	  #(
    	  @output.write(@tokenizer.print_token)
    	  compile_next_token
    	  compile_expression_list
    	  #)
    	  @output.write(@tokenizer.print_token)    	
    	  advance = true
    	end
    end
    if advance
    	compile_next_token
    end
    #more implementation needed
    #compile_next_token
    @output.write("</term>\n")
  end
  
  def compile_expression_list
    @output.write("<expressionList>\n")
	  while !@tokenizer.symbol.eql?(')')
      compile_expression
      #compile_next_token
      # Symbol ','
      while @tokenizer.symbol.eql?(",")
        @output.write(@tokenizer.print_token)
        compile_next_token
        compile_expression
      end
    end
  #compile_expression
   # while @tokenizer.symbol.eql?(",")
    #	@output.write(@tokenizer.print_token)
	#	compile_next_token
    #	compile_expression
   # end
    @output.write("</expressionList>\n")
  end

end