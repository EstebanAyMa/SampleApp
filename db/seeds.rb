User.create!(name:  "Esteban Ayala",
             email: "estebanayala@example.com",
             password:              "estebi02",
             password_confirmation: "estebi02",
             admin: true)

# Generate a bunch of additional users.
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end