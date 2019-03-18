class Organization < ApplicationRecord
	belongs_to :user
	has_many :invites, dependent: :destroy
	mount_uploader :avatar, AvatarUploader
	accepts_nested_attributes_for :invites, allow_destroy: true
end
