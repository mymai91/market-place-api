# Open DB seed

navigate seeds.rb

```
User.delete_all

5.times do
  user = User.create!(email: Faker::Internet.email, password: 'password123')

  puts "Created new user #{user.email}"
end


```
