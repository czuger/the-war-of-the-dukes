namespace :board do
  desc 'Export a board as a json file'
  task export: :environment do

    puts 'Choose board to export'
    puts Board.all.map{ |b| b.id }
    board_id = STDIN.gets.chomp.to_i

    File.open( "data/board_export_#{board_id}.json", 'w' ) do |f|
      f.puts( Board.find( board_id ).pawns.map{ |e| e.minimal_hash }.to_json )
    end

  end

  desc 'Import a board from a json file'
  task import: :environment do

    puts 'Choose board to import (current board will be erased)'
    puts Board.all.map{ |b| b.id }
    board_id = STDIN.gets.chomp.to_i

    puts 'Enter the json filename'
    board_json_filename = STDIN.gets.chomp

    File.open( "data/#{board_json_filename}", 'r' ) do |f|
      board = Board.find( board_id )
      pawns = JSON.parse( f.read() )

      board.pawns.clear
      pawns.each do |pawn|
        board.pawns.create( q: pawn['q'], r: pawn['r'], pawn_type: pawn['pawn_type'], side: pawn['side'] )
      end
    end

  end
end


