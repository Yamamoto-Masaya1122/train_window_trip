require 'csv'

csv = CSV.read('db/fixtures/csv/prefecture.csv', headers: true)
csv.each.with_index(1) do |prefecture, index|
  Prefecture.seed do |s|
    s.id = index
    s.name = prefecture[0]
  end
end