# require 'hex/square_grid'

class TestController < ApplicationController

  include MapHandler

  def show
    set_map
  end

  def full_hex_map
    set_map

    @show_centers = params[:show_centers]
  end

end
