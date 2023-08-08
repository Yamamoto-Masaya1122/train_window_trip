class CreateLines < ActiveRecord::Migration[7.0]
  def change
    create_table :lines do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.text :line_url
      t.string :image
      t.string :recommended_train_window_spot, null: false

      t.timestamps
    end
  end
end
