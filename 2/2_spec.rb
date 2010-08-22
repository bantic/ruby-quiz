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
    
    LCD.print("0", :size => 1).should == zero_text.chomp
    LCD.print("1", :size => 1).should == one_text.chomp
    LCD.print("2", :size => 1).should == two_text.chomp
    LCD.print("3", :size => 1).should == three_text.chomp
    LCD.print("4", :size => 1).should == four_text.chomp
    LCD.print("5", :size => 1).should == five_text.chomp
    LCD.print("6", :size => 1).should == six_text.chomp
    LCD.print("7", :size => 1).should == seven_text.chomp
    LCD.print("8", :size => 1).should == eight_text.chomp
    LCD.print("9", :size => 1).should == nine_text.chomp
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
        
        LCD.print("0", :size => 2).should == zero_text.chomp
        LCD.print("1", :size => 2).should == one_text.chomp
        LCD.print("2", :size => 2).should == two_text.chomp
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
    LCD.print("01", :size => 2).should == zero_one_text.chomp
  end
end