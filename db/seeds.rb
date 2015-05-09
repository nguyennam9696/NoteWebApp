require 'faker'

User.create(:name => 'Nam', :email => 'nam@gmail.com', :password => 'password')

5.times do
  User.create!(:name => Faker::Name.name, :email => Faker::Internet.email, :password => 'password')
end
