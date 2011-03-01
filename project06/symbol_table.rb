class SymbolTable
  @@address = 16
  @@symbol_table = {
    'R0' => '0',
    'R1' => '1',
    'R2' => '2',
    'R3' => '3',
    'R4' => '4',
    'R5' => '5',
    'R6' => '6',
    'R7' => '7',
    'R8' => '8',
    'R9' => '9',
    'R10' => '10',
    'R11' => '11',
    'R12' => '12',
    'R13' => '13',
    'R14' => '14',
    'R15' => '15',
    'SP' => '0',
    'LCL' => '1',
    'ARG' => '2',
    'THIS' => '3',
    'THAT' => '4',
    'KBD'     => '24576',
    'SCREEN'  => '16384'
  }
  
  # This function adds a (key, pair) to the symbol table
  def add_symbol(key, address)
    @@symbol_table.store(key, address)
  end
  
  def get_by_symbol(key)
    '%015b' % @@symbol_table[key]
  end
  
  def add_a_command_symbol(key)
    if @@symbol_table.has_key?(key)
      '%015b' % @@symbol_table[key]
    else
      add_symbol(key, @@address)
      @@address += 1
    end
  end
  
end