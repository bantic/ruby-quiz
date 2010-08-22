class LCD
  
  NUMBERS = [
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
  
  def initialize(string)
    @numbers = string.scan(/\d/).map {|i| i.to_i }
  end
  
  def print(size=DEFAULT_SIZE)
    @size = size
    
    output = []
    
    output << @numbers.map {|number| row0(number)}.join(" ")
    
    @size.times do
      output << @numbers.map{|number| row1(number)}.join(" ")
    end
    
    output << @numbers.map{|number| row2(number)}.join(" ")

    @size.times do
      output << @numbers.map{|number| row3(number)}.join(" ")
    end
    
    output << @numbers.map{|number| row4(number)}.join(" ")
    
    output.join("\n")
  end

  def row0(number)
    " " + (str_for_section(number, 0) * @size) + " "
  end
  
  def str_for_section(number, section)
    string_for_section = [0,3,6].include?(section) ? "-" : "|"
    NUMBERS[number][section] ? string_for_section : " "
  end

  def row1(number)
    str_for_section(number, 1) + (" " * @size) + str_for_section(number, 2)
  end
  
  def row2(number)
    " " + str_for_section(number, 3) * @size + " "
  end
  
  def row3(number)
    str_for_section(number, 4) + (" " * @size) + str_for_section(number, 5)
  end
  
  def row4(number)
    " " + str_for_section(number, 6) * @size + " "
  end
end