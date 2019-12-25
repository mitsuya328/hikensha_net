# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#issue 管理パスワードの環境変数化　テストユーザーの作成
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.first.experiments.create!(name: "テストデータ", deadline: 1.years.after)

Experiment.first.timetables.create!(start_at: 1.week.after)

if Rails.env.development?
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name:  name,
                email: email,
                password:              password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
  end

  users = User.order(:created_at).take(6)
  5.times do |n|
    users.each do |user|
      name = "テストデータ#{n+1} by #{user.name}"
      experiment = user.experiments.create!(name: name, deadline: n.day.after)
      experiment.timetables.create!(start_at: 1.week.after)
    end
  end
end