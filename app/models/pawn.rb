class Pawn < ApplicationRecord
  belongs_to :board

  MOVEMENTS = { 'cav' => 6, 'inf' => 3, 'art' => 3 }

  def remove_dates
    remove_instance_variable(:@created_at)
    self
  end

  def minimal_hash
    { q: q, r: r, pawn_type: pawn_type, side: side }
  end

end
