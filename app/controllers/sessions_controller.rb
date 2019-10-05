class SessionsController < ApplicationController

	def create
		@player = Player.find_or_create_from_auth_hash(auth_hash)
		session['current_player'] = @player
		redirect_to boards_path(@player)
	end

	protected

	def auth_hash
		request.env['omniauth.auth']
	end

end
