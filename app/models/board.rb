class Board < ApplicationRecord
  include AASM

  belongs_to :owner, class_name: 'Player'
  belongs_to :opponent, class_name: 'Player'

  has_many :pawns, dependent: :destroy

  serialize :fight_data

  aasm do
    state :setup
    state :orf_move, initial: true
		state :orf_fight, :orf_advance, :orf_retreat
    state :wulf_move, :wulf_fight, :wulf_advance, :wulf_retreat

    event :orf_move_turn do
      transitions :from => [ :setup, :wulf_fight ], :to => :orf_move
    end

    event :orf_fight_turn do
      transitions :from => :orf_move, :to => :orf_fight
    end

    event :orf_advance_pawn do
      transitions :from => :orf_fight, :to => :orf_advance
    end

    event :wulf_retreat_pawn do
      transitions :from => :orf_fight, :to => :wulf_retreat
    end

    event :orf_back_to_fight do
      transitions :from => [ :orf_advance, :wulf_retreat ], :to => :orf_fight
    end

    event :wulf_move_turn do
      transitions :from => :orf_fight, :to => :wulf_move
    end

    event :wulf_fight_turn do
      transitions :from => :wulf_move, :to => :wulf_fight
    end

    event :wulf_advance_pawn do
      transitions :from => :wulf_fight, :to => :wulf_advance
    end

    event :orf_retreat_pawn do
      transitions :from => :wulf_fight, :to => :orf_retreat
    end

    event :wulf_back_to_fight do
      transitions :from => [ :wulf_advance, :orf_retreat ], :to => :wulf_fight
    end

  end

end