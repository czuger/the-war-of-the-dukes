class Board < ApplicationRecord
  belongs_to :owner, class_name: 'Player'
  belongs_to :opponent, class_name: 'Player'
end
