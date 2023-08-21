class RemoveLineIdFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :line, null: false, foreign_key: true
  end
end
