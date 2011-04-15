class JackTokenizer

  KEYWORDS = ["CLASS", "CONSTRUCTOR", "FUNCTION", "METHOD", "FIELD", "STATIC", "VAR", "INT", "CHAR", "BOOLEAN", "VOID", "TRUE", "FALSE", "NULL", "THIS",
    "LET", "DO", "IF", "ELSE", "WHILE", "RETURN"]
  SYMBOLS = ["{", "}", "(", ")", "[", "]", ".", ",", ";", "+", "-", "*", "/", "&", "|", "<", ">", "=", "~"]
	
  def initialize(file)
  	@readFile = Array.new
    file.each_line do |line| 
      unless line.to_s.index(/((\/\*[^*]*\*\s*\S*)|(\s*[*]+\s*\S*))|(\s*\/\/.*$)/).eql? nil
	#puts line
	line[line.to_s.index(/(\/\*[^*]*\*+(?:[^*\/][^*]*\*+)*\/)|(\s*\/\/.*$)/).to_i..line.to_s.length()-1] = ''
      end
      @readFile.push(line.lstrip)
    end
    @readFile.delete('')
    #puts @readFile
    @currentLine = 0
    @currentToken = ""
    @charPosition = 0
  end
  
  def has_more_tokens?
  	@currentLine < @readFile.length
  end
  
  def advance
   	@currentToken = ""
  	@hasMore = true
   	while @hasMore
  		@currentToken += @readFile[@currentLine][@charPosition].chr		
		if(SYMBOLS.include?(@currentToken))
   			@hasMore = false
   		end
		if(@charPosition == @readFile[@currentLine].length-1)
			@hasMore = false
			@currentLine += 1
			@charPosition = 0
			break
		end
  		if(@currentToken.eql?("\""))
   			until (@readFile[@currentLine][@charPosition+1].chr.eql?("\""))
   				@charPosition += 1
   				@currentToken += @readFile[@currentLine][@charPosition].chr
   			end
   			@charPosition += 1
   			@currentToken += @readFile[@currentLine][@charPosition].chr
			@hasMore = false 
  		elsif(@readFile[@currentLine][@charPosition+1].chr.eql?(" ")) then
   			until(!@readFile[@currentLine][@charPosition+1].chr.eql?(" "))
   				@charPosition += 1
   			end
  			@hasMore = false
   		elsif(SYMBOLS.include?(@readFile[@currentLine][@charPosition+1].chr))
   			@hasMore = false
   			#puts @readFile[@currentLine][@charPosition+1].chr
   		elsif(@readFile[@currentLine][@charPosition+1].chr.eql?("\""))
   			@hasMore = false
  		elsif(@readFile[@currentLine][@charPosition+1].chr.eql?("\n")) then
			@currentLine += 1		
			@charPosition = 0
			break
		end
		#puts @readFile[@currentLine][@i].chr
	  	@charPosition+=1
  	end 
  	#@charPosition += 1
  	puts @currentToken
  end
  
  def token_type
   	if KEYWORDS.include?(@currentToken.upcase)
   		return "KEYWORD"
   	elsif SYMBOLS.include?(@currentToken)
   		return "SYMBOL"
   	elsif @currentToken=~(/^[\d]+(\.[\d]+){0,1}$/)
   		return "INT_CONST"	
   	elsif @currentToken=~(/\"(\S*\s*)*\"/)
   		return "STRING_CONST"
   	else
   		return "IDENTIFIER"
   	end
  end
  
  def key_word
    if token_type.eql?("KEYWORD")
    	return @currentToken.upcase
    end
  end
  
  def symbol
  	if token_type.eql?("SYMBOL")
  		return @currentToken
  	end
  end
  
  def identifier
  	 if token_type.eql?("IDENTIFIER")
  		return @currentToken
  	end
  end
  
  def int_val
  	if token_type.eql?("INT_CONST")
  		return @currentToken
  	end
  end
  
  def string_val
  	if token_type.eql?("STRING_CONST")
  		return @currentToken[1..(@currentToken.length-2)]
  	end
  end
  
  def print_token
  	if token_type == "KEYWORD"
  		return "<keyword>" + key_word.downcase + "</keyword>" + "\n"
  	elsif token_type == "SYMBOL"
  		if @currentToken == "<"
  			return "<symbol> &lt; </symbol>" + "\n"
        elsif @currentToken == ">"
        	return "<symbol> &gt; </symbol>" + "\n"
        elsif @currentToken == "&"
        	return "<symbol> &amp; </symbol>" + "\n"
        else
        	return "<symbol>" + symbol.downcase + "</symbol>" + "\n"
        end
    elsif token_type == "INT_CONST"
    	return "<integerConstant>" + int_val.downcase + "</integerConstant>" + "\n"
    elsif token_type == "STRING_CONST"
    	return "<stringConstant>" + string_val.downcase + "</stringConstant>" + "\n"
    elsif token_type == "IDENTIFIER"
    	return "<identifier>" + identifier.downcase + "</identifier>" + "\n"
	end
  end
  
end
