class EditMapController < ApplicationController

  include MapHandler

  def edit_hexes
    set_map
  end

  def update_hexes
    set_map
    @map.cset( params[:q].to_i, params[:r].to_i, color: params[:color] )
    @map.write_ascii_file_flat_topped_odd( 'data/map.txt' )
    head :ok
  end

  def edit_roads
    set_map

    @json_roads = [].to_json

    if File.exist?( 'data/roads.json' )
      File.open( 'data/roads.json', 'r' ) do |f|
        @json_roads = f.read
      end
    end

    @map.from_json_file( 'data/roads.json' )

    @json_map = @map.to_json
    @json_movement_graph = {}.to_json

    render :edit_hexes
  end

  def update_roads
    map = AxialGrid.new
    map.from_json_file( 'data/roads.json' )
    # puts params[:q].inspect
    map.cset( params[:q].to_i, params[:r].to_i, color: 'R' )
    map.to_json_file( 'data/roads.json' )
    head :ok
  end

end
