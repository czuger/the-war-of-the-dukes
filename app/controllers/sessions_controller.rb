class SessionsController < ApplicationController

	def create
		@player = Player.find_or_create_from_auth_hash(auth_hash)

		# pp @player

		session['current_player_id'] = @player.id
		redirect_to boards_path
	end

	protected

	def auth_hash
		request.env['omniauth.auth']
	end

end
