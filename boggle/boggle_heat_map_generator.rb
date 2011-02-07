require File.dirname(__FILE__) + "/boggle_quiz"

# Board: [["x","u","e","t"],["w","i","o","v"],["i","t","o","y"],["f","o","s","o"]]
# var boggle_tiles = [["b","a","r"],["h","t","k"],["c","d","e"]];

b = Boggle.new(%w{n u s l},
%w{r x n i},
%w{m u a i},
%w{a s m g})

# b = Boggle.new( ["b","a","r"],
#                   ["h","t","k"],
#                   ["c","d","e"])
# 
# b = Boggle.new( ["b","a"],
#                   ["h","t"])


$stdout.sync = true

puts "Solving boggle board..."
puts "Board: #{b.to_json}"
b.words(:min_length => 4)
puts "done."

tile_hash = {}

b.found_paths.each_with_index do |path, idx|
  path.each do |tile|
    col_idx, row_idx = tile[0], tile[1]
    tile_hash[col_idx] ||= {}
    tile_hash[col_idx][row_idx] ||= 0
    tile_hash[col_idx][row_idx] += 1
  end
end

tile_array = []
tile_hash.each do |col, row_hash|
  row_hash.each do |row, heat|
    tile_array[col] ||= []
    tile_array[col][row] = heat
  end
end

max = tile_array.flatten.max
min = tile_array.flatten.min

tile_array_scaled = []
tile_array.each_with_index do |row_arr, col|
  row_arr.each_with_index do |heat, row|
    tile_array_scaled[col] ||= []
    tile_array_scaled[col][row] = (heat - min) / (max - min).to_f
  end
end

b.words.each {|w| puts w}

puts "var boggle_tiles = #{b.to_json};"
puts "var boggle_heats = #{tile_array_scaled.to_json};"
puts "var boggle_paths = #{b.found_paths.to_json};"