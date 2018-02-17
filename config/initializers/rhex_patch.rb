class AxialGrid

  def from_json_file( file_path )
    if File.exist?( file_path )
      json_string = nil
      File.open( file_path, 'r' ) do |f|
        json_string = f.read
      end
      if json_string && !json_string.empty?
        JSON.parse( json_string ).each do |hd|
          cset( hd['q'], hd['r'], color: hd['c'] )
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

end