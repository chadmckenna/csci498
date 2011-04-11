class CompilationEngine
  def initialize(output)
    @output = output
    @output.write("<tokens>\n")
  end
  
  def close
    @output.write("</tokens>\n")
    @output.close
  end
  
  def compile_class
    @output.write('<keyword> class </keyword>\n')
  end
  
  def compile_class_var_dec
    @output.write('Class')
  end
  
  def compile_subroutine
    @output.write('Class')
  end
  
  def compile_parameter_list
    @output.write('Class')
  end
  
  def compile_var_dec
    @output.write('Class')
  end
  
  def compile_statements
    @output.write('Class')
  end
  
  def compile_do
    @output.write('Class')
  end
  
  def compile_let
    @output.write('Class')
  end
  
  def compile_while
    @output.write('Class')
  end
  
  def compile_return
    @output.write('Class')
  end
  
  def compile_if
    @output.write('Class')
  end
  
  def compile_expression
    @output.write('Class')
  end
  
  def compile_term
    @output.write('Class')
  end
  
  def compile_expression_list
    @output.write('Class')
  end
end