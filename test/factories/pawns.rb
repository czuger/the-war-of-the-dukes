FactoryBot.define do
  factory :pawn do
    q {1}
    r {1}
    pawn_type { 'cav' }
    side { 'orf' }
		remaining_movement { 6 }
  end
end
