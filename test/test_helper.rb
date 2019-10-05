require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods

  def discord_fake_login_and_board_create
    OmniAuth.config.test_mode = true

    @player1 = create( :player )
		@player2 = create( :player )
		@board = create( :board, owner: @player1, opponent: @player2 )

    discord_auth_hash =
      {
        :provider => 'discord',
        :uid => @player1.uid,
        info: {
          name: 'Foo Bar',
        }
      }

    OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new    discord_auth_hash

    post '/auth/discord'
    follow_redirect!

    @user
  end
end
