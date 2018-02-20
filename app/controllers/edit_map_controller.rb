class EditMapController < ApplicationController

  include MapHandler

  ROADS_FILE = 'data/roads.json'
  RIVERS_FILE = 'data/rivers.json'

  def full_hex_map
    set_map

    @show_centers = params[:show_centers]
  end

  def edit_hexes
    set_map
  end

  def update_hexes
    set_map
    @map.cset( params[:q].to_i, params[:r].to_i, color: params[:color] )
    @map.write_ascii_file_flat_topped_odd( 'data/map.txt' )
    head :ok
  end

  def edit_top_layer
    set_map

    top_layer_file = params[:layer] == 'roads' ? ROADS_FILE : RIVERS_FILE

    @json_top_layer = [].to_json

    if File.exist?( top_layer_file )
      File.open( top_layer_file, 'r' ) do |f|
        @json_top_layer = f.read
      end
    end

    @map.from_json_file( top_layer_file )

    @json_map = @map.to_json
    @json_movement_graph = {}.to_json

    render :edit_hexes
  end

  def update_top_layer

    top_layer_file = params[:layer] == 'roads' ? ROADS_FILE : RIVERS_FILE

    map = AxialGrid.new
    map.from_json_file( top_layer_file )
    # puts params[:q].inspect

    if params[:color] == ''
      map.cclear( params[:q].to_i, params[:r].to_i )
    else
      map.cset( params[:q].to_i, params[:r].to_i, color: 'R' )
    end

    map.to_json_file( top_layer_file )
    head :ok
  end

end
