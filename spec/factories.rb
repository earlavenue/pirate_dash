FactoryGirl.define do
  factory :client do
    first_name "Fool"
    last_name "Barbarian"
    password "foobar"
    password_confirmation "foobar"
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
    sequence(:code) { |c| "mike#{c}" }

    factory :omron_organization do
      name "Omron Fitness"
      code "zach"
    end

    factory :general_organization do
      name "General"
      code "general"
    end
  end

  factory :person do
    sequence(:user_id) { |n| n }
    sequence(:first_name) { |n| "Homer#{n}" }
    last_name "Simpson"
    sequence(:email) { |n| "#{first_name}#{n}@gmail.com" }
    date_created Time.now
    last_upload Time.now
    password "password123"
    pw_reset ""
  end

  factory :membership do
    person_id 54321
    organization_id 98765
    first_upload_date (Time.zone.now.to_date - 3.months)
  end

  factory :upload do
    sequence(:id) { |n| n }
    date Time.zone.now
    total_steps 100
    aerobic_steps 75
    distance 500.0
    calories 50
    device_model "blah"
    sequence(:device_serial) { |n| "HJ#{n}" }
    is_device_input 0
    server_time Time.now
    person
  end
end
