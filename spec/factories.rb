FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "foo#{n}" }
    last_name "Dummy"
    password "foobar"
    email { "#{first_name}@example.com" }
    organization

    factory :omron_user do
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
    first_name "Homer"
    last_name "Simpson"
    email "#{first_name}@gmail.com"
    dev_serial "HJ9393"
    organization
  end
end


