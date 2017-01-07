class AddPostToChatRoom < ActiveRecord::Migration[5.0]
  def change
    change_table(:chat_rooms) do |t|
      t.text :post
      t.integer   :likes
      t.integer   :dislikes
    end
  end
end
