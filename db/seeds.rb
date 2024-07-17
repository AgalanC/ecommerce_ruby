# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Ensure AdminUser exists
AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end if Rails.env.development?

require 'faker'
require 'open-uri'

# Clear existing data
Category.destroy_all
Beer.destroy_all
Tax.destroy_all

# Create categories
categories = ["Sours", "IPAs", "Lagers", "Stouts"].map do |category_name|
  Category.create!(name: category_name, description: Faker::Lorem.sentence(word_count: 10))
end

# Create products with better descriptions and attach images
100.times do
  beer = Beer.new(
    name: Faker::Beer.name,
    description: "#{Faker::Beer.style} with notes of #{Faker::Food.ingredient} and #{Faker::Food.spice}. Perfect for a #{Faker::Hipster.word} evening.",
    price: Faker::Commerce.price(range: 5..20),
    stock_quantity: Faker::Number.between(from: 10, to: 100),
    category: categories.sample,
    beer_type: Faker::Beer.style
  )

  # Attempt to attach a random image
  begin
    image_url = "https://picsum.photos/200/300"
    downloaded_image = URI.open(image_url)
    beer.image.attach(io: downloaded_image, filename: "beer_#{beer.name.parameterize}.jpg")
  rescue Socket::ResolutionError => e
    puts "Failed to download image for #{beer.name}: #{e.message}"
  end

  beer.save!
end

# Create initial StaticPages
StaticPage.find_or_create_by!(title: 'About') do |page|
  page.content = 'This is the about page content.'
end

StaticPage.find_or_create_by!(title: 'Contact') do |page|
  page.content = 'This is the contact page content.'
end

# Create provinces and their respective taxes
Tax.create(province: 'Alberta', pst_rate: 0.0, gst_rate: 0.05, hst_rate: 0.0, qst_rate: 0.0)
Tax.create(province: 'British Columbia', pst_rate: 0.07, gst_rate: 0.05, hst_rate: 0.0, qst_rate: 0.0)
Tax.create(province: 'Manitoba', pst_rate: 0.07, gst_rate: 0.05, hst_rate: 0.0, qst_rate: 0.0)
Tax.create(province: 'New Brunswick', pst_rate: 0.0, gst_rate: 0.0, hst_rate: 0.15, qst_rate: 0.0)
Tax.create(province: 'Newfoundland and Labrador', pst_rate: 0.0, gst_rate: 0.0, hst_rate: 0.15, qst_rate: 0.0)
Tax.create(province: 'Nova Scotia', pst_rate: 0.0, gst_rate: 0.0, hst_rate: 0.15, qst_rate: 0.0)
Tax.create(province: 'Ontario', pst_rate: 0.0, gst_rate: 0.0, hst_rate: 0.13, qst_rate: 0.0)
Tax.create(province: 'Prince Edward Island', pst_rate: 0.0, gst_rate: 0.0, hst_rate: 0.15, qst_rate: 0.0)
Tax.create(province: 'Quebec', pst_rate: 0.0, gst_rate: 0.05, hst_rate: 0.0, qst_rate: 0.09975)
Tax.create(province: 'Saskatchewan', pst_rate: 0.06, gst_rate: 0.05, hst_rate: 0.0, qst_rate: 0.0)
Tax.create(province: 'Northwest Territories', pst_rate: 0.0, gst_rate: 0.05, hst_rate: 0.0, qst_rate: 0.0)
Tax.create(province: 'Nunavut', pst_rate: 0.0, gst_rate: 0.05, hst_rate: 0.0, qst_rate: 0.0)
Tax.create(province: 'Yukon', pst_rate: 0.0, gst_rate: 0.05, hst_rate: 0.0, qst_rate: 0.0)
