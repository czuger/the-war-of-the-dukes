require 'pp'

class User < ApplicationRecord

	def self.find_or_create_from_auth_hash(auth_hash)

		User.find_or_create_by!( provider: auth_hash['provider'], uid: auth_hash['uid'] ) do |user|
			user.name = auth_hash['info']['name']
		end

	end
end
