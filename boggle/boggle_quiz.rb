class Boggle
  DEFAULT_MAX_LENGTH = 10
  DEFAULT_MIN_LENGTH = 3
  
  def self.word_dictionary_file
    @@word_dictionary_file = "/usr/share/dict/words"
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
  
  def [](col_idx, row_idx)
    return nil if col_idx < 0 || row_idx < 0
    if @rows[row_idx]
      @rows[row_idx][col_idx]
    end
  end
  
  def letter_sequences(opts={})
    @max_length = opts[:max_length] || DEFAULT_MAX_LENGTH
    @min_length = opts[:min_length] || DEFAULT_MIN_LENGTH
    @visited_paths = []
    @found_paths   = []
    follow_path([[0,0]]).collect do |path|
      path.collect {|tuple| self[*tuple]}
    end
  end
  
  DIRECTIONS = ["E","S","W","N"] #,"NE", "SE", "NW", "SW"]
  
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
  
  def follow_path_right(path)
    follow_path_dir(path, "E")
  end

  def follow_path_up(path)
    follow_path_dir(path, "N")
  end

  def follow_path_down(path)
    follow_path_dir(path, "S")
  end

  def follow_path_left(path)
    follow_path_dir(path, "W")
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
      [ col_idx + 1, row_idx - 1]
    when "SE"
      [ col_idx + 1, row_idx + 1]
    when "SW"
      [ col_idx + 1, row_idx - 1]
    end
    
    puts "dir: #{dir}. cur tuple: #{current_tuple.inspect}. next tuple: #{next_tuple.inspect}. letter? #{ self[*next_tuple]}. path: #{path.inspect}. path includes? #{path.include?(next_tuple)}. paths: #{@visited_paths.inspect}<br />\n"
    
    return unless self[ *next_tuple ]
    if !path.include?(next_tuple)
      puts "path didn't include #{next_tuple.inspect}. current @visited_paths: #{@visited_paths.inspect}<br>"
      path << next_tuple
      puts "new path: #{path.inspect}<br>"
      puts "current @visited_paths: #{@visited_paths.inspect}<br>"
      if !@visited_paths.include?(path)
        if path.size >= @min_length
          @found_paths << path
        end
        @visited_paths << path
        puts "@visited_paths didn't include the new path. new @visited_paths: #{@visited_paths.inspect}. RETURNING!<Br>"
        return follow_path(path)
      else
        puts "@visited_paths included new path. @visited_paths: #{@visited_paths.inspect}. new path: #{path.inspect}"
        return nil
      end
    end
  end
  
end