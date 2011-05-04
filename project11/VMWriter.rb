class VMWriter
	def initialize(output)
		@output = output
	end
	
	def write_push(segment, index)
		@ouput.write("push" + segment + " " + index + "\n")
	end
	
	def write_pop(segment, index)
		@output.write("pop" + segment + " " + index + "\n")
	end
	
	def write_arithmetic(command)
		@output.write(command + "\n")
	end
	
	def write_label(label)
		@output.write("label" + label + "\n")
	end
	
	def write_goto(label)
		@output.write("goto" + label + "\n")
	end
	
	def write_if(label)
		@output.write("if-goto" + label + "\n")
	end
	
	def write_call(name, nArgs)
		@output.write("call" + name + " " + nArgs + "\n")
	end
	
	def write_function(name, nLocals)
		@output.write("function" + name + " " + nLocals + "\n")		
	end
	
	def write_return
		@output.write("return\n")
	end

end