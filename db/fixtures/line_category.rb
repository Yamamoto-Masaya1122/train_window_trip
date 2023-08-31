require 'csv'

csv = CSV.read('db/fixtures/csv/line_category.csv', headers: true)
csv.each.with_index(1) do |line_category, index|
  LineCategory.seed do |s|
    s.id = index
    s.line_id = line_category[0]
    s.category_id = line_category[1]
  end
end