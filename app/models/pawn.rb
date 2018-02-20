class Pawn < ApplicationRecord
  belongs_to :board

  def remove_dates
    remove_instance_variable(:@created_at)
    self
  end

end
