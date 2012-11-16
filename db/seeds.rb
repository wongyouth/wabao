# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

50.times do |i|
  Item.create!(
    num_iid: i,
    title: "title-#{i}",
    nick: "nick-#{i}",
    pic_url: "http://placehold.it/230x230",
    click_url: "http://placehold.it/230x230",
    price: "100#{i}",
    commission: "3#{i}",
    volume: "1#{i}"
  )
end

if User.all.size == 0
  User.create!({
    :email => 'wongyouth@gmail.com',
    :roles => ['admin'],
    :password => 'ryan12345',
    :password_confirmation => 'ryan12345'
  })
end

