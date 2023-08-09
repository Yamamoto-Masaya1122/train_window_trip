class CreatePrefectureLines < ActiveRecord::Migration[7.0]
  def change
    create_table :prefecture_lines do |t|
      t.references :prefecture, null: false, foreign_key: true
      t.references :line, null: false, foreign_key: true

      t.timestamps
    end
  end
end
