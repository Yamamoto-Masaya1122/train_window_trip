require 'csv'

csv = CSV.read('db/fixtures/csv/line.csv', headers: true)
csv.each.with_index(1) do |line, index|
  Line.seed do |s|
    s.id = index
    s.name = line[0]
    s.description = line[1]
    s.line_url = line[2]
    s.image = line[3]
    s.recommended_train_window_spot = line[4]
  end
end