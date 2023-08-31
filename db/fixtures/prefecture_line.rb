require 'csv'

csv = CSV.read('db/fixtures/csv/prefecture_line.csv', headers: true)
csv.each.with_index(1) do |prefecture_line, index|
  PrefectureLine.seed do |s|
    s.id = index
    s.prefecture_id = prefecture_line[0]
    s.line_id = prefecture_line[1]
  end
end