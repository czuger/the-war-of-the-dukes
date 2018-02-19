json.extract! board, :id, :owner_id, :opponent_id, :turn, :created_at, :updated_at
json.url board_url(board, format: :json)
