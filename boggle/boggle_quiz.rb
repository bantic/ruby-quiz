begin
  require 'json'
rescue LoadError => e
  require "rubygems"
  require "json"
end

class Boggle
  DEFAULT_MAX_LENGTH = 10
  DEFAULT_MIN_LENGTH = 3
  
  attr_accessor :found_paths, :words
  
  def self.word_dictionary_file
    @@word_dictionary_file ||= "/usr/share/dict/words"
  end
  
  def self.matches_word?(word_fragment)
     !`grep -i -e "^#{word_fragment}" #{word_dictionary_file}`.empty?
  end
  
  def self.word_exists?(full_word)
    !`grep -i -e "^#{full_word}$" #{word_dictionary_file}`.empty?
  end
  
  def initialize(*val_array)
    @rows = *val_array
  end
  
  def to_json
    @rows.to_json
  end
  
  def [](col_idx, row_idx)
    return nil if col_idx < 0 || row_idx < 0
    if @rows[row_idx]
      @rows[row_idx][col_idx]
    end
  end
  
  def words(opts={})
    letter_sequences(opts.merge({:words => true}))
    @words
  end
  
  def letter_sequences(opts={})
    @max_length = opts[:max_length] || DEFAULT_MAX_LENGTH
    @min_length = opts[:min_length] || DEFAULT_MIN_LENGTH
    @only_include_words = opts[:words] || false
    @visited_paths = []
    @found_paths   = []
    @words         = []
    0.upto(@rows.size - 1).each do |row_idx|
      0.upto(@rows[0].size - 1).each do |col_idx|
        follow_path([[col_idx, row_idx]])
      end
    end
    
    @found_paths.collect do |path|
      path.collect {|tuple| self[*tuple]}
    end
  end
  
  DIRECTIONS = ["E","S","W","N","NE", "SE", "NW", "SW"]
  
  private
  
  def follow_path(path)
    path = path.dup
    return @found_paths if path.empty?
    DIRECTIONS.each do |direction|
      new_paths = follow_path_dir(path, direction)
      if new_paths.nil? && direction == DIRECTIONS.last
        path.pop
        return follow_path(path)
      end
    end
  end
  
  def follow_path_dir(path, dir)
    return nil if path.size >= @max_length
    path = path.dup
    col_idx, row_idx = path.last
    
    current_tuple = [col_idx, row_idx]
    
    next_tuple = case dir
    when "N"
      [ col_idx, row_idx - 1 ]
    when "E"
      [col_idx + 1, row_idx]
    when "S"
      [ col_idx, row_idx + 1 ]
    when "W"
      [ col_idx - 1, row_idx ]
    when "NW"
      [ col_idx - 1, row_idx - 1]
    when "NE"
      [ col_idx - 1, row_idx + 1]
    when "SE"
      [ col_idx + 1, row_idx + 1]
    when "SW"
      [ col_idx + 1, row_idx - 1]
    end
    
    return unless self[ *next_tuple ]
    if !path.include?(next_tuple)
      path << next_tuple
      if !@visited_paths.include?(path)
        text = path.collect{|tuple| self[*tuple]}.join
        if path.size >= @min_length
          if @only_include_words && Boggle.word_exists?(text)
            @found_paths << path
            @words       << text
          else
            @found_paths << path
          end
        end
        @visited_paths << path
        if @only_include_words && !Boggle.matches_word?(text)
          return
        else
          return follow_path(path)
        end
      end
    end
  end
  
end