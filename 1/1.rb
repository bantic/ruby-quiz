module Highline
  def self.ask(text)
    print text
    return (gets).chomp
  end
end

class MadLibs
  TOKEN_REGEXP = /\(\(.*?\)\)/
  
  def initialize(text)
    @text = text
  end
  
  def run!
    puts "Welcome to MadLibs. Here we go..."
    tokens.each do |token|
      token.value ||= Highline::ask("What's the value for '#{token}'? ")
    end
    puts output
  end
  
  def tokens
    @token_collection ||= begin
      collection = MadLibs::TokenCollection.new
      @text.scan(TOKEN_REGEXP).map do |text|
        text_without_parens = text.sub(/^\(\(/,'').sub(/\)\)$/,'')
        collection << MadLibs::Token.from_text(text_without_parens)
      end
      collection
    end.tokens
  end
  
  def output
    match_index = -1
    @text.gsub(TOKEN_REGEXP) do |match|
      match_index += 1
      tokens[match_index].value
    end
  end
end

class MadLibs::Token
  attr_reader :text, :name
  attr_accessor :value
  
  def initialize(text, name=nil)
    @text = text
    @name = name
  end
  
  def self.from_text(text)
    name, text = text.split(":")
    text = name and name = nil if text.nil?
    new(text,name)
  end
  
  def ==(other)
    @text == other.text && @name == other.name
  end
  
  def to_s
    @text
  end
end

class MadLibs::TokenCollection
  attr_accessor :tokens
  
  def initialize
    @tokens = []
  end
  
  def <<(new_token)
    token_to_add = @tokens.find {|t| new_token.text == t.name } || new_token
    @tokens << token_to_add
    self
  end
end