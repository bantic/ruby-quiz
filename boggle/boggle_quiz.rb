class Boggle
  DEFAULT_MAX_LENGTH = 10
  def initialize(*val_array)
    @rows = *val_array
  end
  
  def [](col_idx, row_idx)
    if @rows[row_idx]
      @rows[row_idx][col_idx]
    end
  end
  
  def letter_sequences(opts={})
    max_length = opts[:max_length] || DEFAULT_MAX_LENGTH
    
    follow_path([[0,0]])
  end
  
  private
  
  def follow_path(path, paths=[])
    return paths if path.empty?
    right_paths = follow_path_right(path, paths)
    if right_paths.nil?
      left_paths  = follow_path_left(path, paths)
      if left_paths.nil?
        down_paths  = follow_path_down(path, paths)
        if down_paths.nil?
          up_paths    = follow_path_up(path, paths)
          if up_paths.nil?
            path.pop
            return follow_path(path, paths)
          end
        end
      end
    end
  end
  
  def follow_path_right(path, paths)
    follow_path_dir(path, paths, "right")
  end

  def follow_path_up(path, paths)
    follow_path_dir(path, paths, "up")
  end

  def follow_path_down(path, paths)
    follow_path_dir(path, paths, "down")
  end

  def follow_path_left(path, paths)
    follow_path_dir(path, paths, "left")
  end

  
  def follow_path_dir(path, paths, dir)
    col_idx, row_idx = path.last
    
    next_tuple = case dir
    when "up"
      [ col_idx, row_idx - 1 ]
    when "right"
      [col_idx + 1, row_idx]
    when "down"
      [ col_idx, row_idx + 1 ]
    when "left"
      [ col_idx, row_idx + 1 ]
    end
    
    puts "dir: #{dir}, next tuple: #{next_tuple.inspect}. letter? #{ self[*next_tuple]}. path includes? #{path.include?(next_tuple)}. paths: #{paths.inspect}<br />\n"
    
    return unless self[ *next_tuple ]
    if !path.include?(next_tuple)
      path << next_tuple
      if !paths.include?(path)
        follow_path(path, paths << path)
      end
    end
  end
  
end