class Device < ApplicationRecord
  belongs_to :user
  has_many :requests

  enum status: { available: 0, unavailable: 1 }
end
