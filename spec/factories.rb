FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "foo#{n}" }
    last_name "Dummy"
    password "foobar"
    email { "#{first_name}@example.com" }
    organization

     factory :omron do
       organization "Omron Fitness"
     end
  end

  factory :organization do
    sequence(:name) { |n| "org#{n}"}
    address "Somewherez"
    city "Hellzville"
    state "Up yo mama"
    zip "666"

  end
end


