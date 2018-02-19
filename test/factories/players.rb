FactoryBot.define do
  factory :player do
    sequence :name do |n|
      "person#{n}@example.com"
    end
  end
end
