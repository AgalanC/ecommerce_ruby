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

# Clear existing data
Category.destroy_all
Beer.destroy_all

# Create categories
categories = ["Sours", "IPAs", "Lagers", "Stouts"].map do |category_name|
  Category.create!(name: category_name, description: Faker::Lorem.sentence)
end

# Create products
100.times do
  Beer.create!(
    name: Faker::Beer.name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price(range: 5..20),
    stock_quantity: Faker::Number.between(from: 10, to: 100),
    category: categories.sample,
    beer_type: Faker::Beer.style
  )
end

# Create initial StaticPages
StaticPage.find_or_create_by!(title: 'About') do |page|
  page.content = 'This is the about page content.'
end

StaticPage.find_or_create_by!(title: 'Contact') do |page|
  page.content = 'This is the contact page content.'
end
