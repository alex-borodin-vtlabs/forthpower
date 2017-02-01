class ChatRoom < ApplicationRecord
  belongs_to :user
  validates_presence_of :user
  has_many :messages, dependent: :destroy
  validates :title, presence: true, length: {minimum: 2, maximum: 1000}
  acts_as_votable
  after_create_commit { ChatRoomsBroadcastJob.perform_later(self, 'create') }
  after_update_commit { ChatRoomsBroadcastJob.perform_later(self, 'update') }

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end

  def self.search(search)
    where("(title LIKE ?) OR (post LIKE ?)", "%#{search}%", "%#{search}%")
  end
end
