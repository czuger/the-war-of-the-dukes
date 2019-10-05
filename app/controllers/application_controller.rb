class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_player
		@current_player ||= session['current_player']
		# pp @current_player
	end

end
