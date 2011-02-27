class Code
  @@dest = {
    'null'  => '00',
    'M'     => '01',
    'D'     => '02',
    'MD'    => '03',
    'A'     => '04',
    'AM'    => '05',
    'AD'    => '06',
    'AMD'   => '07', 
  }
  
  @@comp = {
    'D&A'   => '0',
    'D+A'   => '2',
    'A-D'   => '7',
    'D'     => '12',
    '!D'    => '13',
    'D-1'   => '14',
    '-D'    => '15',
    'D-A'   => '19',
    'D|A'   => '21',
    'D+1'   => '31',
    '0'     => '42',
    'A'     => '48',
    '!A'    => '49',
    'A-1'   => '50',
    '-A'    => '51',
    'A+1'   => '55',
    '-1'    => '58',
    '1'     => '63',
    'D&M'   => '64',
    'D+M'   => '66',
    'M-D'   => '71',
    'D-M'   => '83',
    'D|M'   => '85',
    'M'     => '112',
    '!M'    => '113',
    'M-1'   => '114',
    '-M'    => '115',
    'M+1'   => '119',
  }
  
  @@jump = {
    'null'  => '00',
    'JGT'   => '01',
    'JEQ'   => '02',
    'JGE'   => '03',
    'JLT'   => '04',
    'JNE'   => '05',
    'JLE'   => '06',
    'JMP'   => '07',
  }
  
  def initilize 
    
  end
  
  # Returns the binary code of the dest.
  def self.dest(key)
    '%03b' % @@dest[key]
  end
  
  # Returns the binary code of the comp.
  def self.comp(key)
    '%07b' % @@comp[key]
  end
  
  # Returns the binary code of the jump.
  def self.jump(key)
    '%03b' % @@jump[key]
  end
end