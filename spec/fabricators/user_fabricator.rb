Fabricator(:user) do
  name { Faker::Name.name }
  email { sequence(:email){ |i| "user#{i}@example.com" } }
  password "password"
end
