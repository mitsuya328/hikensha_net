# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テストユーザー
User.create!(name:  "Test User",
             email: "test@hikensha.net",
             password:              "password",
             password_confirmation: "password",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)

# テストユーザーの実験
User.first.experiments.create!(name: "【サンプル】心理実験被験者募集",
                               deadline: 1.years.after,
                               description: 'こちらはサンプルです。申し込みを行っても実験に参加することはできません',
                               location: '東京都',
                               reward: '0')
3.times do |n|
  Experiment.first.timetables.create!(start_at: n.week.after, number_of_subjects: 3)
end

Timetable.first.subjects.create!(email: "subject@hikensha.net",
                                sex: '1',
                                birth_date: 20.years.ago)

User.create!(name:  "Admin User",
             email: ENV['ADMIN_EMAIL'],
             password:              ENV['ADMIN_PASSWORD'],
             password_confirmation: ENV['ADMIN_PASSWORD'],
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

if Rails.env.development?
  30.times do |n|
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

  users = User.order(:created_at).take(10)
  3.times do |n|
    users.each do |user|
      name = "実験#{n+1} by #{user.name}"
      experiment = user.experiments.create!(name: name, deadline: n.day.after)
      3.times do |j|
        experiment.timetables.create!(start_at: j.week.after, number_of_subjects: 3)
      end
    end
  end
end