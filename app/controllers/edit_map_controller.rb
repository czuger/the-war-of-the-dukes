class EditMapController < ApplicationController

	include MapHandler

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

	def edit_rivers
	end

	def update_top_layer
		set_map_data
		head :ok
	end

end
