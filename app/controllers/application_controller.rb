class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_player
		@current_player ||= ( (s=session['current_player_id']) && Player.find( s ) )
		# pp @current_player
	end

end
