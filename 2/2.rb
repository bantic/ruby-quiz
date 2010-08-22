class LCD
  NUMBER_SECTIONS = [
    [true,  true,  true, false, true,  true,  true],
    [false, false, true, false, false, true,  false],
    [true,  false, true, true,  true,  false, true],
    [true,  false, true,  true,  false, true,  true],
    [false, true,  true,  true,  false, true,  false],
    [true,  true,  false, true,  false, true,  true],
    [true,  true,  false, true,  true,  true,  true],
    [true,  false, true,  false, false, true,  false],
    [true,  true,  true,  true,  true,  true,  true],
    [true,  true,  true,  true,  false, true,  true]
  ]
  
  DEFAULT_SIZE = 2
  
  HORIZ_SEGMENT = "-"
  VERT_SEGMENT  = "|"
  SEPARATOR     = " "
  
  def initialize(string)
    @numbers = string.scan(/\d/).map {|i| i.to_i }
  end
  
  def print(size=DEFAULT_SIZE)
    @size = size
    
    output = []
    
    output << row0(@numbers)
    
    @size.times do
      output << row1(@numbers)
    end
    
    output << row2(@numbers)

    @size.times do
      output << row3(@numbers)
    end
    
    output << row4(@numbers)
    
    output.join("\n")
  end

  def row0(numbers)
    numbers.map do |number|
      SEPARATOR + (str_for_section(number, 0) * @size) + SEPARATOR
    end.join(SEPARATOR)
  end
  
  def str_type_for_section(section)
    [0,3,6].include?(section) ? HORIZ_SEGMENT : VERT_SEGMENT
  end
  
  def lit_for_section(number, section)
    NUMBER_SECTIONS[number][section]
  end
  
  def str_for_section(number, section)
   lit_for_section(number, section) ? str_type_for_section(section) : SEPARATOR
  end

  def row1(numbers)
    numbers.map do |number|
      str_for_section(number, 1) + (SEPARATOR * @size) + str_for_section(number, 2)
    end.join(SEPARATOR)
  end
  
  def row2(numbers)
    numbers.map do |number|
      SEPARATOR + str_for_section(number, 3) * @size + SEPARATOR
    end.join(SEPARATOR)
  end
  
  def row3(numbers)
    numbers.map do |number|
      str_for_section(number, 4) + (SEPARATOR * @size) + str_for_section(number, 5)
    end.join(SEPARATOR)
  end
  
  def row4(numbers)
    numbers.map do |number|
      SEPARATOR + str_for_section(number, 6) * @size + SEPARATOR
    end.join(SEPARATOR)
  end
end