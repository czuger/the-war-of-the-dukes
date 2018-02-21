class AxialGrid

  def from_json_file( file_path )
    if File.exist?( file_path )
      json_string = nil
      File.open( file_path, 'r' ) do |f|
        json_string = f.read
      end
      if json_string && !json_string.empty?
        JSON.parse( json_string ).each do |hd|
          cset( hd['q'], hd['r'], data: hd['data'] )
        end
      end
    end
  end

  def to_json_file( file_path )
    # puts self.to_json
    File.open( file_path, 'w' ) do |f|
      f.write( self.to_json )
    end
  end

  def cclear( q, r )
    @hexes.delete( [q, r ] )
  end

  # Return the grid as a json string
  #
  # @return [Array] the grid as a json string
  def to_json
    a = @hexes.map{ |e| { q: e[0][0], r: e[0][1], data: e[1].data } }
    a.to_json
  end

  # Read an ascii file and load it into the hexagon grid. The input grid is supposed to be odd flat topped (odd-q) and will be stored into an axial representation.
  #
  # @param file_path [String] the name of the ascii file to read. For how to create this file, please see : https://github.com/czuger/rhex#reading-a-grid-from-an-ascii-file
  def read_ascii_file_flat_topped_odd( file_path )
    File.open( file_path ) do |file|

      odd = 0
      base_q = 0
      line_q = 0

      file.each_line do |line|
        elements = line.split
        elements.each_with_index do |element, index|
          # puts "element = %c, index = %d || q = %d, r = %d" % [element, index, index*2 + odd, base_q - index]
          # cset( index*2 + odd, base_q - index, color: element.to_sym, border: nil )
          q = index*2 + odd
          r = base_q - index
          @hexes[ [ q, r ] ] = AxialHex.new( q, r, data: { color: element.to_sym } )
        end

        odd = ( odd.odd? ? 0 : 1 )

        line_q += 1
        if line_q >= 2
          line_q = 0
          base_q += 1
        end

      end
    end
  end

end