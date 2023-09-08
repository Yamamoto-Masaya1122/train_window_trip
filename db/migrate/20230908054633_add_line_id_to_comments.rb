class AddLineIdToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :line, foreign_key: true, null: false
  end
end
