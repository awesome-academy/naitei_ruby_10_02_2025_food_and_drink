categories = []
5.times do |i|
  categories << Category.create!(
    name: "Category #{i + 1}"
  )
end

10.times do |i|
  product = Product.create!(
    name: "Product #{i + 1}",
    price: rand(10..500),
    description: "Description for product #{i + 1}"
  )

  product.categories << categories.sample(rand(1..3))
end
