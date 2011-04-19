
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
284
285
286
287
288
289
290
291
292
293
294
295
296
297
298
299
300
301
302
303
304
305
306
307
308
309
310
311
312
313
314
315
316
317
318
319
320
321
322
323
324
325
326
327
328
329
330
331
332
333
334
335
336
337
338
339
340
341
342
343
344
345
346
347
348
349
350
351
352
353
354
355
356
357
358
359
360
361
362
363
364
365
366
367
368
369
370
371
372
373
374
375
376
377
378
379
380
381
382
383
384
385
386
387
388
389
390
391
392
393
394
395
396
397
398
399
400
401
402
403
404
405
406
407
408
409
410
411
412
413
414
415
416
417
418
419
420
421
422
423
424
425
426
427
428
429
430
431
432
433
434
435
436
437
438
439
440
441
442
443
444
445
446
447
448
449
450
451
452
453
454
455
456
457
458
459
460
461
462
463
464
465
466
467
468
469
470
471
472
473
474
475
476
477
478
479
480
481
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
    #compile_next_token
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
    #compile_next_token
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
  		#compile_next_token
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
  	#compile_next_token
  	
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
  
  ############################################
   def compile_term
    @advance = false
  	@output.write("<term>\n")
    if @tokenizer.token_type.eql?("STRING_CONST") or @tokenizer.token_type.eql?("INT_CONST") or @tokenizer.token_type.eql?("KEYWORD")
    	@output.write(@tokenizer.print_token)
    	@advance = true
    elsif @tokenizer.symbol.eql?("(")
    	#(
    	@output.write(@tokenizer.print_token)
    	compile_next_token
    	compile_expression
    	#)
    	@output.write(@tokenizer.print_token)
    	@advance = true
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
    		@advance = true
        elsif @tokenizer.symbol.eql?("(")
        	#(
        	@output.write(@tokenizer.print_token)
    		compile_next_token
			compile_expression_list
			compile_next_token
			#)
			@output.write(@tokenizer.print_token)
			@advance = true
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
	    	@advance = true
    	end
    end
    if @advance
    	compile_next_token
    end
    #more implementation needed
    #compile_next_token
    @output.write("</term>\n")
  end
  
  def compile_expression_list
    @output.write("<expressionList>\n")
	compile_expression
    while @tokenizer.symbol.eql?(",")
    	@output.write(@tokenizer.print_token)
		compile_next_token
    	compile_expression
    end
    @output.write("</expressionList>\n")
  end

end