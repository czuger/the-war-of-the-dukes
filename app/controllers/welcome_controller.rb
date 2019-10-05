class WelcomeController < ApplicationController
  def show
    if current_player
			redirect_to boards_path
		end
  end
end
