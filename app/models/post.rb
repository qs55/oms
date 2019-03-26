class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
  mount_uploader :avatar, AvatarUploader
  validates :avatar, presence: true
end
