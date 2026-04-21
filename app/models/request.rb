class Request < ApplicationRecord
  belongs_to :user # 申請者
  belongs_to :approver, class_name: "User" # 承認者
  belongs_to :device

  enum status: { pending: 0, approved: 1, rejected: 2, returned: 3 }

  validates :start_date, presence: true
  validates :end_date, presence: true, comparison: { greater_than_or_equal_to: :start_date }

  def status_i18n
    I18n.t("activerecord.attributes.request.status.#{status}")
  end
end
