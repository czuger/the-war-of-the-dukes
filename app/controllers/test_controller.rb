# require 'hex/square_grid'

class TestController < ApplicationController
  def show

    g = SquareGridFlatTopped.new

    # Load it with
    g.read_ascii_file_flat( 'app/controllers/map' )

    p g

    @map = g.to_json
    p @map
  end

end
