class RemoveCommentableFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :commentable, polymorphic: true, null: false
  end
end
