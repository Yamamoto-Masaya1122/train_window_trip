require 'csv'


csv = CSV.read('db/line.csv', headers: true)
csv.each.with_index(1) do |line, index|
  Line.create! do |s|
    s.id = index
    s.name = line[0]
    s.description = line[1]
    s.line_url = line[2]
    s.image = line[3]
    s.recommended_train_window_spot = line[4]
  end
end

csv = CSV.read('db/prefecture.csv', headers: true)
csv.each.with_index(1) do |prefecture, index|
  Prefecture.create! do |s|
    s.id = index
    s.name = prefecture[0]
  end
end

csv = CSV.read('db/category.csv', headers: true)
csv.each.with_index(1) do |category, index|
  Category.create! do |s|
    s.id = index
    s.name = category[0]
  end
end

csv = CSV.read('db/prefecture_line.csv', headers: true)
csv.each.with_index(1) do |prefecture_line, index|
  PrefectureLine.create! do |s|
    s.id = index
    s.prefecture_id = prefecture_line[0]
    s.line_id = prefecture_line[1]
  end
end

csv = CSV.read('db/line_category.csv', headers: true)
csv.each.with_index(1) do |line_category, index|
  LineCategory.create! do |s|
    s.id = index
    s.line_id = line_category[0]
    s.category_id = line_category[1]
  end
end