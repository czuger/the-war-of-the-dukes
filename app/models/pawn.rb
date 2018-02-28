class Pawn < ApplicationRecord
  belongs_to :board

  def remove_dates
    remove_instance_variable(:@created_at)
    self
  end

  def minimal_hash
    { q: q, r: r, pawn_type: pawn_type, side: side }
  end

end
