class EditMapController < ApplicationController

  include MapHandler

  def show
    set_map
  end

  def update
    set_map
    @map.cset( params[:q].to_i, params[:r].to_i, color: params[:color] )
    @map.write_ascii_file_flat_topped_odd( 'data/map.txt' )
    head :ok
  end

end
