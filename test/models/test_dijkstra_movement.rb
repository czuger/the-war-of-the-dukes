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

    walkable_positions = {}
    current_hex = AxialHex.new( 13, 4 )

    DijkstraMovement.find( @map, @movement_graph, current_hex )

    p walkable_positions.keys

    assert walkable_positions.has_key?( '3_3')
    assert walkable_positions.has_key?( '2_3')
  end
end