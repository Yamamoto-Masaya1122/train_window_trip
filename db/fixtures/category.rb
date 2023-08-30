require 'csv'

csv = CSV.read('db/fixtures/csv/category.csv', headers: true)
csv.each.with_index(1) do |category, index|
  Category.create! do |s|
    s.id = index
    s.name = category[0]
  end
end