class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_player
		begin
			@current_player ||= ( (s=session['current_player_id']) && Player.find( s ) )
		rescue
			@current_player = session['current_player_id'] = nil
		end

		# pp @current_player
	end

end
