class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :posts, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :comments
  has_one :organization , dependent: :destroy
  accepts_nested_attributes_for :organization, allow_destroy: true
  accepts_nested_attributes_for :posts, allow_destroy: true 
  accepts_nested_attributes_for :comments, allow_destroy: true
  accepts_nested_attributes_for :invites, allow_destroy: true

  has_many :subordinates, class_name: "User",
                          foreign_key: "manager_id"
 
  belongs_to :manager, class_name: "User"


  protected
    def password_required?
      confirmed? ? super : false
    end


end
