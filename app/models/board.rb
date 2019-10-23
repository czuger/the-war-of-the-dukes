class Board < ApplicationRecord
  include AASM

  belongs_to :owner, class_name: 'Player'
  belongs_to :orf, class_name: 'Player'
	belongs_to :wulf, class_name: 'Player'

  has_many :pawns, dependent: :destroy
	has_many :board_histories, dependent: :destroy

  serialize :fight_data

  aasm do
    state :setup
    state :orf_turn, initial: true
		state :orf_retreat
    state :wulf_turn, :wulf_retreat

    event :next_to_orf_turn do
      transitions :from => [ :setup, :wulf_turn ], :to => :orf_turn
		end

    event :next_to_wulf_turn do
      transitions :from => [ :setup, :orf_turn ], :to => :wulf_turn
    end

		event :next_to_orf_retreat do
			transitions :from => [ :wulf_turn, :orf_turn ], :to => :orf_retreat
		end

		event :next_to_wulf_retreat do
			transitions :from => [ :wulf_turn, :orf_turn ], :to => :wulf_retreat
		end

	end

end