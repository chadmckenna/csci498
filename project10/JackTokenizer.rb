class JackTokenizer

  KEYWORDS = ["CLASS", "CONSTURCTOR", "FUNCTION", "METHOD", "FIELD", "STATIC", "VAR", "INT", "CHAR", "BOOLEAN", "VOID", "TRUE", "FALSE", "NULL", "THIS",
    "LET", "DO", "IF", "ELSE", "WHILE", "RETURN"]
  SYMBOLS = ["{", "}", "(", ")", "[", "]", ".", ",", ";", "+", "-", "*", "/", "&", "|", "<", ">", "=", "~"]
	
  def initialize(file)
  	@readFile = Array.new
    file.each_line do |line| 
      unless line.to_s.index(/(\/\*[^*]*\*+(?:[^*\/][^*]*\*+)*\/)|(\/\/.*$)/).eql? nil
        line[line.to_s.index(/(\/\*[^*]*\*+(?:[^*\/][^*]*\*+)*\/)|(\/\/.*$)/).to_i..line.to_s.length()] = ''
      end
      @readFile.push(line.lstrip)
    end
    @readFile.delete('')
    puts @readFile
    @currentLine = 0
    @currentToken = ""
    @charPosition = 0
  end
  
  def has_more_tokens?
  	@currentLine != @readFile.length
  end
  
  def advance
   	@currentToken = ""
  	@hasMore = true
   	while @hasMore
  		@currentToken += @readFile[@currentLine][@charPosition].chr
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
 	if KEYWORDS.include?(@currentToken)
 		return "KEYWORD"
 	elsif SYMBOLS.include?(@currentToken)
 		return "SYMBOL"
 	elsif @currentToken.is_a?(Integer)
 		return "INT_CONST"
 	#elsif @currentToken is a identifier
 	# => return "IDENTIFIER"	
 	#elsif @currentToken is_a?(String)
 	#	return "STRING_CONST"
 	end
  end
  
  def key_word
    if token_type.eql?("KEYWORD")
    	return @currentToken
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
end