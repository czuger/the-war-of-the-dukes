class Board < ApplicationRecord
  include AASM

  belongs_to :owner, class_name: 'Player'
  belongs_to :orf, class_name: 'Player'
	belongs_to :wulf, class_name: 'Player'

  has_many :pawns, dependent: :destroy
	has_many :board_histories, dependent: :destroy

  serialize :fight_data
	serialize :retreating_pawn

	ORF = 'orf'.freeze
	WULF = 'wulf'.freeze

  aasm do
    state :setup
    state :action_phase, initial: true
		state :retreat

    event :start_retreat do
      transitions :from => :action_phase, :to => :retreat
		end

    event :end_retreat do
			transitions :from => :retreat, :to => :action_phase
    end

	end

end