# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

order_status = ['ready', 'on its way', 'delivered']

5.times do
  Customer.create(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name
  )
end


3.times do
  Order.create(
    customer_id: rand(1..5),
    status: order_status[rand(2)]
  )
end


Category.create(name: "Games")
Category.create(name: "Books")
Category.create(name: "Movies")


3.times do
  Product.create(name: Faker::Game.unique.title)
end

3.times do
  Product.create(name: Faker::Book.unique.title)
end

3.times do
  Product.create(name: Faker::Movie.unique.title)
end

(1..3).each do |category_id|
  (1..3).each do |j|
    product_id = 3 * (category_id - 1) + j
    ProductCategory.create(
      product_id: product_id,
      category_id: category_id
    )
  end
end


(1..3).each do |order_id|
  num_items = rand(1..9)
  product_ids = []
  num_items.times do
    product_id = rand(1..9) while product_ids.include?(product_id)
    product_ids << product_id
    OrderProduct.create(
      order_id: order_id,
      product_id: product_id,
      quantity: rand(1.0..10.0).round(2),
      created_at: '2021-03-11'
    )
  end
end

(1..3).each do |order_id|
  num_items = rand(1..9)
  product_ids = []
  num_items.times do
    product_id = rand(1..9) while product_ids.include?(product_id)
    product_ids << product_id
    OrderProduct.create(
      order_id: order_id,
      product_id: product_id,
      quantity: rand(1.0..10.0).round(2),
      created_at: '2021-03-18'
    )
  end
end

(1..3).each do |order_id|
  num_items = rand(1..9)
  product_ids = []
  num_items.times do
    product_id = rand(1..9) while product_ids.include?(product_id)
    product_ids << product_id
    OrderProduct.create(
      order_id: order_id,
      product_id: product_id,
      quantity: rand(1.0..10.0).round(2),
      created_at: '2021-04-10'
    )
  end
end
