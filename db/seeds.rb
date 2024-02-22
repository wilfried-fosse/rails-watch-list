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

Movie.destroy_all
List.destroy_all
Bookmark.destroy_all
10.times do
  Movie.create!(
    title: Faker::Movie.title,
    overview: Faker::Movie.quote,
    poster_url: Faker::Internet.url,
    rating: rand(1..10)
  )
end
puts "Created #{Movie.count} movies."
# Créer des listes
10.times do
  List.create!(
    name: Faker::Book.title
  )
end
puts "Created #{List.count} lists."
if Movie.any? && List.any?
  10.times do
    Bookmark.create!(
      comment: Faker::Lorem.sentence(word_count: 5),
      movie: Movie.all.sample,
      list: List.all.sample
    )
  end
  puts "Created #{Bookmark.count} bookmarks."
else
  puts 'No movies or lists found. Bookmarks were not created.'
end
