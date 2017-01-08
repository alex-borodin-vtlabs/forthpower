module ChatRoomsHelper
  def preview_text(chat_room)
    strip_tags(chat_room.post.to_s).truncate(500)
  end

  def preview_image(chat_room)
    doc = Nokogiri::HTML(chat_room.post.to_s)
    img = doc.search('img').first
    return unless img
    img.set_attribute('class', 'card-img-top')
    img.set_attribute('style', 'max-width:100%')
    img.to_s.html_safe
  end

  def hide_vote(chat_room, user)
    return true unless user
    user.voted_for? chat_room
  end
end
