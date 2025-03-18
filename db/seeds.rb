require "open-uri"

categories = []
5.times do |i|
  categories << Category.create!(name: "Category #{i + 1}")
end

10.times do |i|
  product = Product.create!(
    name: "Product #{i + 1}",
    price: rand(10..500),
    description: "Description for product #{i + 1}"
  )

  product.categories << categories.sample(rand(1..3))

  file = URI.open("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpDKovOW04qaFTlIGW0cqR8Up2yZxNHujnkA&s")
  product.image.attach(io: file, filename: "product_#{i + 1}.jpg")
end
