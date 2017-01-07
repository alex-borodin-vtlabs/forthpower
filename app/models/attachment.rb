class Attachment < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user
  validates :user, presence: true
end
