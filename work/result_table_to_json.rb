require 'pp'
require 'json'

columns = %w( 1-5 1-4 1-3 1-2 1-1 2-1 3-1 4-1 5-1 6-1 )

final_hash = {}
File.open('../data/result_table.txt','r').readlines.each_with_index do |line, index|
  final_hash[ index+1 ] = Hash[ line.split( ' ' ).each_with_index.map{ |e, i| [ columns[ i ], e ] } ]
end

File.open('../data/result_table.json','w') do |f|
  f.write( final_hash.to_json )
end