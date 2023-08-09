class CreateLineCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :line_categories do |t|
      t.references :line, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
