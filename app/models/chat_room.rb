class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :title, presence: true, length: {minimum: 2, maximum: 1000}
  after_create_commit { ChatRoomsBroadcastJob.perform_later(self) }

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
