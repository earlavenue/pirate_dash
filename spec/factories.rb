FactoryGirl.define do
  factory :client do
    first_name "Fool"
    last_name "Barbarian"
    password "foobar"
    sequence(:email) { |n| "#{first_name}#{n}@example.com" }
    organization

    factory :omron_client do
      association :organization, :factory => [:omron_organization]
    end
  end

  factory :organization do
    sequence(:name) { |n| "org#{n}"}
    address "Somewherez"
    city "Hellzville"
    state "Up yo mama"
    zip "666"

    factory :omron_organization do
      name "Omron Fitness"
    end
  end

  factory :person do
    sequence(:first_name) { |n| "Homer#{n}" }
    last_name "Simpson"
    sequence(:email) { |n| "#{first_name}#{n}@gmail.com" }
    dev_serial "HJ9393"
    organization
  end

  factory :upload do
    upload_time Date.current
    dev_serial "HJ666"
    association :person
    total_steps 100
    total_aerobic_steps 75
    distance 500
    calories 50
  end
end
