# require 'hex/square_grid'

class TestController < ApplicationController





  def full_hex_map
    set_map

    @show_centers = params[:show_centers]
  end

end
