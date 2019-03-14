class Post < ApplicationRecord
  belongs_to :User
  mount_uploader :avatar, AvatarUploader
end
