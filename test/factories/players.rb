FactoryBot.define do
  factory :player do

    sequence :name do |n|
      "person#{n}@example.com"
		end

		sequence :uid do |n|
			n
		end

		provider { :discord }

  end
end
