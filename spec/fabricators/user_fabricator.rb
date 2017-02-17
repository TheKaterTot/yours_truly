Fabricator(:user) do
  name { Faker::Name.name }
  email { sequence(:email){ |i| "user#{i}@example.com" } }
  password "password"
  password_confirmation "password"
end
