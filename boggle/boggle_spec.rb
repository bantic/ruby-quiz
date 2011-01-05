require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Boggle do
  before(:each) do
    @b = Boggle.new( ["a","b","c","d"],
                    ["e","f","g","h"],
                    ["i","j","k","l"],
                    ["m","n","o","p"])
  end

  it "should be addressable by [row, col]" do
    @b[0,0].should == "a"
    @b[1,0].should == "b"
    @b[0,1].should == "e"
    @b[3,3].should == "p"
    @b[4,0].should be_nil
    @b[0,4].should be_nil
    @b[4,4].should be_nil
  end
  
  it "should be able to generate legal letter sequences" do
    @letter_sequences = @b.letter_sequences(:max_length => 3)
    @letter_sequences.should include?(["a","b","c"])
    @letter_sequences.should include?(["a","b","f"])
    @letter_sequences.should include?(["a","e","f"])
    @letter_sequences.should include?(["a","e","i"])
  end
end