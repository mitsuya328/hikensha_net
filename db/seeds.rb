# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Admin User",
             email: "admin@hikensha.net",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
User.first.experiments.create!(name: "テストデータ", deadline: 1.years.after)
3.times do |n|
  Experiment.first.timetables.create!(start_at: n.week.after, number_of_subjects: 3)
end

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

  users = User.order(:created_at).take(2)
  3.times do |n|
    users.each do |user|
      name = "テストデータ#{n+1} by #{user.name}"
      experiment = user.experiments.create!(name: name, deadline: n.day.after)
      3.times do |j|
        experiment.timetables.create!(start_at: j.week.after, number_of_subjects: 3)
      end
    end
  end
end