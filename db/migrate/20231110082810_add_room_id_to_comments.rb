class AddRoomIdToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :room, null: false, foreign_key: true
  end
end
