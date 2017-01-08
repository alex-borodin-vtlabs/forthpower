class AddPostToChatRoom < ActiveRecord::Migration[5.0]
  def change
    change_table(:chat_rooms) do |t|
      t.text :post
    end
  end
end
