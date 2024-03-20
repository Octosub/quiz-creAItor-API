# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

puts "Removing existing Tests"
Test.destroy_all

puts "creating Tests"
counter = 0
3.times do
  counter += 1
  puts "creating test #{counter}"
  answer1 = Faker::Lorem.word
  answer2 = Faker::Lorem.word
  answer3 = Faker::Lorem.word

  Test.create(max_score: rand(100..200), time: rand(10000..20000), challenges: {
    challenge1: {
      question: Faker::Lorem.question,
      choices: {
        a: answer1,
        b: Faker::Lorem.word,
        c: Faker::Lorem.word
      },
      answer: answer1
    },
    challenge2: {
      question: Faker::Lorem.question,
      choices: {
        a: answer2,
        b: Faker::Lorem.word,
        c: Faker::Lorem.word
      },
      answer: answer2
    },
    challenge3: {
      question: Faker::Lorem.question,
      choices: {
        a: answer3,
        b: Faker::Lorem.word,
        c: Faker::Lorem.word
      },
      answer: answer3
    }
  })
end
puts "Created #{counter} Tests 📝"
