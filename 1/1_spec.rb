require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MadLibs do
  context "parsing tokens" do
    it "should get normal tokens" do
      m = MadLibs.new("I ((a verb, past tense)) to the sandwich")
      m.tokens.should == [MadLibs::Token.new("a verb, past tense")]
    end
    
    it "should get named tokens" do
      m = MadLibs.new("I got him a ((gift:a noun)).")
      m.tokens.should == [MadLibs::Token.new("a noun", "gift")]
    end
    
    it "should refer to a named token by its name only later" do
      m = MadLibs.new("I got him a ((gift:a noun)).  I said I got him a ((gift)).")
      token = MadLibs::Token.new("a noun", "gift")
      m.tokens.should == [token, token]
      m.tokens.first.object_id.should == m.tokens.last.object_id
    end
  end
  
  context "substitutions" do
    it "should substitute the values for tokens" do
      m = MadLibs.new("I ((a verb, past tense)) to the sandwich")
      m.tokens.first.value = "slid"
      m.output.should == "I slid to the sandwich"
    end
    
    it "should work with multiple tokens" do
      m = MadLibs.new("I ((a verb, past tense)) to the sandwich ((noun)).")
      m.tokens.first.value = "slid"
      m.tokens.last.value  = "hut"
      m.output.should == "I slid to the sandwich hut."
    end
    
    it "should work with named tokens" do
      m = MadLibs.new("I got him a ((gift:a noun)).  I said I got him a ((gift)).")
      m.tokens.first.value = "horse"
      m.output.should == "I got him a horse.  I said I got him a horse."
    end
  end
  
  context "tokens" do
    it "should have an optional name" do
      t = MadLibs::Token.new("a noun","gift")
      t.name.should == "gift"
    end
  end
end

__END__
For my ((a family member))'s ((an event)) present about ((a number)) years ago,
I got him a ((gift:a noun)).   Not a ((an adjective)) ((gift)) or a loud one or
even a ((an adjective)) ((gift)) that runs around chasing its ((a body part))
and drooling on the ((a noun)).  I got them a ((a proper noun)), bred in China
thousands of years ago to be the ((a plural noun)) of the royal family.  We
named it ((a proper name)).