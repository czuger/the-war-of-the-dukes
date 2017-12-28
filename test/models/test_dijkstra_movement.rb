require 'test_helper'

class TestDijkstraMovement < ActiveSupport::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @map = AxialGrid.new
    @map.read_ascii_file_flat_topped_odd( 'data/map.txt' )
    @movement_graph = JSON.restore( File.open( 'data/movement_graph.json' ) )
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_movement_computation

    current_hex = AxialHex.new( 13, 4 )

    fh = DijkstraMovement.find( @map, @movement_graph, current_hex, 6 )

    puts 'Frontier history = '
    p fh.select{ |e| e =~ /.+_3/ }.sort

    assert fh.include?( '3_3')
    assert fh.include?( '2_3')
    refute fh.include?( '2_2')

    assert fh.include?( '16_1')
    refute fh.include?( '17_0')

  end
end