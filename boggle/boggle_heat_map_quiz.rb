require File.dirname(__FILE__) + "/boggle_quiz"

b = Boggle.new(%w{n u s l},
%w{r x n i},
%w{m u a i},
%w{a s m g})

puts "Solving boggle board..."
puts "Board: #{b.to_json}"
b.words(:min_length => 4)
puts "done."

tile_hash = {}

puts "Found #{b.found_paths.size} paths."

b.found_paths.each_with_index do |path, idx|
  puts idx if idx % 10 == 0
  path.each do |tile|
    col_idx, row_idx = tile[0], tile[1]
    tile_hash[col_idx] ||= {}
    tile_hash[col_idx][row_idx] ||= 0
    tile_hash[col_idx][row_idx] += 1
  end
end

puts "Paths: #{b.found_paths.inspect}"

puts "Tile hash: #{tile_hash.inspect}"
tile_array = []
tile_hash.each do |col, row_hash|
  row_hash.each do |row, heat|
    tile_array[col] ||= []
    tile_array[col][row] = heat
  end
end

puts "Tile array: #{tile_array.inspect}"

max = tile_array.flatten.max
min = tile_array.flatten.min

tile_array_scaled = []
tile_array.each_with_index do |row_arr, col|
  row_arr.each_with_index do |heat, row|
    tile_array_scaled[col] ||= []
    tile_array_scaled[col][row] = (heat - min) / (max - min).to_f
  end
end

puts "Tile array scaled: #{tile_array_scaled.inspect}"
