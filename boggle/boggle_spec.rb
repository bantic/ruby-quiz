require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

$stdout.sync

describe Boggle do
  context "basic" do
    before(:each) do
      @b = Boggle.new( ["a","b","c","d"],
                      ["e","f","g","h"],
                      ["i","j","k","l"],
                      ["m","n","o","p"])
    end

    it "should be addressable by [col, row]" do
      @b[0,0].should == "a"
      @b[1,0].should == "b"
      @b[0,1].should == "e"
      @b[3,3].should == "p"
      @b[4,0].should be_nil
      @b[0,4].should be_nil
      @b[4,4].should be_nil
    end

    it "should not allow negative row or col indexes" do
      @b[-1,0].should be_nil
      @b[0,-1].should be_nil
    end
    
    context "#to_json" do
      it "should give a good json output" do
        @b.to_json.should == "[[\"a\",\"b\",\"c\",\"d\"],[\"e\",\"f\",\"g\",\"h\"],[\"i\",\"j\",\"k\",\"l\"],[\"m\",\"n\",\"o\",\"p\"]]"
      end
    end
  end
  
  context "word matching" do
    it "should match starts words" do
      Boggle.matches_word?("absten").should be_true
      Boggle.matches_word?("absTEN").should be_true
      Boggle.matches_word?("abstentsislk").should be_false
    end
    
    it "should not match nothing" do
      Boggle.matches_word?(nil).should be_false
      Boggle.matches_word?("").should be_false

      Boggle.word_exists?(nil).should be_false
      Boggle.word_exists?("").should be_false
    end
    
    it "should check for existence of words" do
      Boggle.word_exists?("abstentious").should be_true
      Boggle.word_exists?("absTENTious").should be_true
      Boggle.word_exists?("absten").should be_false
    end
  end
  
  context "solving boards" do
    before(:each) do
      @b2 = Boggle.new( ["b","a","r"],
                        ["h","t","k"],
                        ["c","d","e"])
    end
    it "should find words" do
      words = @b2.words
      words.should include("bat")
      words.should include("bath")
      words.should include("batch")
      words.should include("bark")
      words.should include("chat")
    end
    it "should find words with min length" do
      words = @b2.words(:min_length => 5)
      words.each {|w| w.length.should >= 5}
    end
    it "should find these words" do
      boggle = Boggle.new(%w{s e e o},
                          %w{h k s l},
                          %w{o c u t},
                          %w{e j k i})
      words = boggle.words(:min_length => 4)
      words.should include("seek")
      words.should include("skeo")
      words.should include("shock")
      words.should include("shoe")
    end
  end
  
  context "finding word paths" do
    before(:each) do
      @b = Boggle.new( ["b","a"],
                       ["h","t"])
    end
    it "should find the correct paths" do
      @b.words
      @b.found_words.size.should == @b.found_paths.size
    end
  end
  
  context "letter sequences" do
    before(:each) do
      @b = Boggle.new( ["a","b"],
                      ["e","f"])
    end
    it "should be able to generate legal letter sequences" do
      letter_sequences = @b.letter_sequences(:min_length => 2)
      letter_sequences.should include(["a","b"])
      letter_sequences.should include(["a","b","f"])
      letter_sequences.should include(["a","f"])
      letter_sequences.should include(["a","f","b"])
      letter_sequences.should include(["a","f","b","e"])
      letter_sequences.should include(["a","b","f","e"])
      letter_sequences.should include(["a","e"])
      letter_sequences.should include(["a","e","b"])
      letter_sequences.should include(["a","e","b","f"])
      letter_sequences.should include(["a","e","f"])
      letter_sequences.should include(["a","e","f","b"])
    end
    
    it "should accept min_length" do
      letter_sequences = @b.letter_sequences(:min_length => 3)
      letter_sequences.each do |sequence|
        sequence.size.should >= 3
      end
    end
    
    it "should accept max_length" do
      letter_sequences = @b.letter_sequences(:max_length => 3)
      letter_sequences.each do |sequence|
        sequence.size.should <= 3
      end
    end
  end
end