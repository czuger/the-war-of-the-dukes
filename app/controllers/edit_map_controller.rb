class EditMapController < ApplicationController

  def full_hex_map
    @show_centers = params[:show_centers]
  end

  def edit_hexes
  end

  def update_hexes
    map = AxialGrid.from_json_file( 'data/map.json' )
    map.cset( params[:q].to_i, params[:r].to_i, data: { color: params[:color] } )
    map.to_json_file( 'data/map.json' )
    head :ok
  end

  def edit_top_layer
    # @map = AxialGrid.from_json_file( top_layer_file )
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

end
