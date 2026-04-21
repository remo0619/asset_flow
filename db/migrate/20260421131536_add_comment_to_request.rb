class AddCommentToRequest < ActiveRecord::Migration[7.2]
  def change
    add_column :requests, :comment, :text
  end
end
