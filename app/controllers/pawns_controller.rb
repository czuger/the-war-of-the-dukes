class PawnsController < ApplicationController

  def create
    @pawn = p.create!( q: params[:q], r: params[:r] )
    head :ok
  end

  def update
    p = Pawn.find( params[:pawn_id])
    p.update!( q: params[:q], r: params[:r] )
    render json: { pawn_id: p.id }
  end

  def delete
    raise 'Not implemented'
  end
end
