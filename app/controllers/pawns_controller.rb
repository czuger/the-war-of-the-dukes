class PawnsController < ApplicationController

  def create
    @pawn = @board.pawns.create!( pawn_params )
    render json: { pawn_id: @pawn.id }
  end

  def update
    p = Pawn.find( params[:id])
    p.update!( q: params[:q], r: params[:r] )
    head :ok
  end

  def destroy
    Pawn.destroy( params[:id] )
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def pawn_params
    params.permit(:q, :r, :pawn_type, :side)
  end

end
