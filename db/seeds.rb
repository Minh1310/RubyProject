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

# Clear the existing data
Customer.destroy_all
Order.destroy_all
Book.destroy_all
Review.destroy_all
Supplier.destroy_all
Author.destroy_all
BookOrder.destroy_all

# Create Suppliers
5.times do
  Supplier.create(
    name: Faker::Company.name
  )
end
puts "Created #{Supplier.count} suppliers"

# Create Authors
10.times do
  Author.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    title: Faker::Job.title
  )
end
puts "Created #{Author.count} authors"

# Create Books
20.times do
  Book.create(
    title: Faker::Book.title,
    year_published: Faker::Number.between(from: 1900, to: 2023),
    isbn: Faker::Number.number(digits: 13),
    price: Faker::Commerce.price(range: 10..100),
    out_of_print: Faker::Boolean.boolean,
    views: Faker::Number.between(from: 0, to: 1000),
    supplier: Supplier.all.sample,
    author: Author.all.sample
  )
end
puts "Created #{Book.count} books"

# Create Customers
15.times do
  Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    title: Faker::Job.title,
    email: Faker::Internet.email,
    visits: Faker::Number.between(from: 1, to: 100),
    orders_count: 0, # Will be updated as orders are created
    lock_version: Faker::Number.between(from: 1, to: 10)
  )
end
puts "Created #{Customer.count} customers"

# Create Orders and associate them with Books (BookOrder)
50.times do
  order = Order.create(
    date_submitted: Faker::Time.backward(days: 365),
    status: Faker::Number.between(from: 0, to: 3),
    subtotal: Faker::Commerce.price(range: 20..200),
    shipping: Faker::Commerce.price(range: 5..20),
    tax: Faker::Commerce.price(range: 1..15),
    total: Faker::Commerce.price(range: 25..250),
    customer: Customer.all.sample
  )

  # Create BookOrders (many-to-many relationship between Order and Book)
  books = Book.all.sample(Faker::Number.between(from: 1, to: 5))
  books.each do |book|
    BookOrder.create(order: order, book: book)
  end

  # Update customer's orders_count
  customer = order.customer
  customer.update(orders_count: customer.orders_count + 1)
end
puts "Created #{Order.count} orders"

# Create Reviews for Books
30.times do
  Review.create(
    title: Faker::Lorem.sentence(word_count: 3),
    body: Faker::Lorem.paragraph(sentence_count: 5),
    rating: Faker::Number.between(from: 1, to: 5),
    state: Faker::Number.between(from: 0, to: 3),
    customer: Customer.all.sample,
    book: Book.all.sample
  )
end
puts "Created #{Review.count} reviews"
