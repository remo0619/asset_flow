class Device < ApplicationRecord
  belongs_to :user
  has_many :requests, dependent: :restrict_with_error

  enum status: { available: 0, borrowed: 1, unavailable: 2 }

  validates :serial, length: { maximum: 30 }, presence: true,
                      uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :device_type, length: { maximum: 20 }, presence: true

  def status_i18n
    I18n.t("activerecord.attributes.device.status.#{status}")
  end
end
