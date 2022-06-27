FactoryBot.define do
  factory :weapon do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    power_base { FFaker::Random.rand(100..9000) }
    power_step { FFaker::Random.rand(10..1000) }
    level { 1 }
  end
end
