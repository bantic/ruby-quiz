require 'redis'
class RedisTrie
  TERMINATOR = "*"
  PREFIX = :compl
  
  def initialize(file)
    @redis = Redis.new
    if !@redis.exists(PREFIX)
      File.open(file) do |f|
        f.each_line do |word|
          word = word.strip.downcase
          (1..(word.length)).each {|l|
            prefix = word[0...l]
            @redis.zadd(PREFIX,0,prefix)
          }
          @redis.zadd(PREFIX,0,word + TERMINATOR)
        end
      end
    end
  end
  
  def matches_word?(word_fragment)
    !@redis.zrank(PREFIX, word_fragment).nil?
  end
  
  def word_exists?(full_word)
    !@redis.zrank(PREFIX, full_word + TERMINATOR).nil?
  end
end