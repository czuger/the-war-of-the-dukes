# require 'hex/square_grid'

class TestController < ApplicationController
  def show

    g = SquareGrid.new

    # Load it with
    g.read_ascii_file( 'app/controllers/map' )

    @map = g.to_json
  end

end
