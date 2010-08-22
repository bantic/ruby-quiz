class LCD
  # Sections are labeled top-to-bottom, left-to-right, like so:
  #            
  #     --0-- 
  #    |     |
  #    |     |
  #    1     2
  #    |     |
  #    |     |
  #     --3-- 
  #    |     |
  #    |     |
  #    4     5
  #    |     |
  #    |     |
  #     --6--
  #

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

  def lit_for_section(number, section)
    NUMBER_SECTIONS[number][section]
  end

  def str_type_for_section(section)
    [0,3,6].include?(section) ? HORIZ_SEGMENT : VERT_SEGMENT
  end

  def str_for_section(number, section)
   lit_for_section(number, section) ? str_type_for_section(section) : SEPARATOR
  end

  def horiz_row(number, section)
    SEPARATOR + (str_for_section(number, section) * @size) + SEPARATOR
  end
  
  def vert_row(number, section_left, section_right)
    str_for_section(number, section_left) + 
      (SEPARATOR * @size) + 
      str_for_section(number, section_right)
  end

  def row0(numbers)
    numbers.map do |number|
      horiz_row(number, 0)
    end.join(SEPARATOR)
  end
  
  def row1(numbers)
    numbers.map do |number|
      vert_row(number, 1, 2)
    end.join(SEPARATOR)
  end
  
  def row2(numbers)
    numbers.map do |number|
      horiz_row(number, 3)
    end.join(SEPARATOR)
  end
  
  def row3(numbers)
    numbers.map do |number|
      vert_row(number, 4, 5)
    end.join(SEPARATOR)
  end
  
  def row4(numbers)
    numbers.map do |number|
      horiz_row(number, 6)
    end.join(SEPARATOR)
  end
end