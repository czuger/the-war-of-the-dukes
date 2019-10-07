FactoryBot.define do
  factory :board_history do
    board { nil }
    turn { 1 }
    movements_increments { 1 }
    pawns_positions { "" }
  end
end
