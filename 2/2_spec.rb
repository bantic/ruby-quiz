require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LCD do
  it "should print a single digit correctly" do
    zero_text = <<-EOS
 - 
| |
   
| |
 - 
EOS
    one_text = <<-EOS
   
  |
   
  |
   
EOS
    two_text = <<-EOS
 - 
  |
 - 
|  
 - 
EOS
    three_text = <<-EOS
 - 
  |
 - 
  |
 - 
EOS
    four_text = <<-EOS
   
| |
 - 
  |
   
EOS
    five_text = <<-EOS
 - 
|  
 - 
  |
 - 
EOS
    six_text = <<-EOS
 - 
|  
 - 
| |
 - 
EOS
    seven_text = <<-EOS
 - 
  |
   
  |
   
EOS
    eight_text = <<-EOS
 - 
| |
 - 
| |
 - 
EOS
    nine_text = <<-EOS
 - 
| |
 - 
  |
 - 
EOS
    nine_text = nine_text.chomp
               
    LCD.new("0").print(1).should == zero_text.chomp
    LCD.new("1").print(1).should == one_text.chomp
    LCD.new("2").print(1).should == two_text.chomp
    LCD.new("3").print(1).should == three_text.chomp
    LCD.new("4").print(1).should == four_text.chomp
    LCD.new("5").print(1).should == five_text.chomp
    LCD.new("6").print(1).should == six_text.chomp
    LCD.new("7").print(1).should == seven_text.chomp
    LCD.new("8").print(1).should == eight_text.chomp
    LCD.new("9").print(1).should == nine_text.chomp
  end
  
  it "should print correctly with size == 2" do
        zero_text = <<-EOS
 -- 
|  |
|  |
    
|  |
|  |
 -- 
EOS
        
        one_text = <<-EOS
    
   |
   |
    
   |
   |
    
EOS
        
        two_text = <<-EOS
 -- 
   |
   |
 -- 
|   
|   
 -- 
EOS
        
        LCD.new("0").print(2).should == zero_text.chomp
        LCD.new("1").print(2).should == one_text.chomp
        LCD.new("2").print(2).should == two_text.chomp
  end
  
  it "should print multiple numbers ok" do
    zero_one_text = <<-EOS
 --      
|  |    |
|  |    |
         
|  |    |
|  |    |
 --      
EOS
    LCD.new("01").print(2).should == zero_one_text.chomp
  end
end