class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :video_id, null: false, unique: true
      t.string :title, null: false
      t.string :thumbnail, null: false
      t.integer :view_count, null: false
      t.datetime :published_at, null: false
      t.references :line, null: false, foreign_key: true
      t.text :description, null: false

      t.timestamps
    end
  end
end