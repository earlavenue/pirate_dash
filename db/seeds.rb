raise "Can't run in #{Rails.env}" unless Rails.env.development?

User.destroy_all
User.create(
    {email: 'pirate@example.com',
    first_name: 'Edward',
    last_name: 'Teach',
    password: '12345',
    password_confirmation: '12345'})

puts 'Log in as Edward Teach with these credentials:'
puts 'email: "pirate@example.com"'
puts 'password: "12345"'
