class EditMapController < ApplicationController

  FILES = {
      'roads' => 'data/roads.json', 'rivers' => 'data/rivers.json', 'orf_border' => 'data/orf_border.json'
  }

  def full_hex_map
    set_map

    @show_centers = params[:show_centers]
  end

  def edit_hexes
    set_map
  end

  def update_hexes
    set_map
    @map.cset( params[:q].to_i, params[:r].to_i, data: { color: params[:color] } )
    @map.to_json_file( 'data/map.json' )
    head :ok
  end

  def edit_top_layer
    set_map

    top_layer_file = FILES[params[:layer]]

    @json_top_layer = [].to_json

    if File.exist?( top_layer_file )
      File.open( top_layer_file, 'r' ) do |f|
        @json_top_layer = f.read
      end
    end

    # @map = AxialGrid.from_json_file( top_layer_file )

    @json_map = @map.to_json
    @json_movement_graph = {}.to_json

    render :edit_hexes
  end

  def update_top_layer

    top_layer_file = FILES[params[:layer]]

    map = AxialGrid.from_json_file( top_layer_file )
    # puts params[:q].inspect

    if params[:color] == ''
      map.cclear( params[:q].to_i, params[:r].to_i )
    else
      map.cset( params[:q].to_i, params[:r].to_i, data:{ color: params[:color] } )
    end

    map.to_json_file( top_layer_file )
    head :ok
  end

  private

  def set_map
    @json_movement_graph = File.open( 'data/movement_graph.json' ).read
    @map = AxialGrid.from_json_file( 'data/map.json' )
    @json_map = @map.to_json
  end


end
