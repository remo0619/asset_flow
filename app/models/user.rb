class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :devices
  has_many :requests

  enum authority: { user: 0, admin: 1 }

  validates :name, length: { maximum: 20 }, presence: true
  validates :email, presence: true
end
