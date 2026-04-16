class Request < ApplicationRecord
  belongs_to :user
  belongs_to :device

  enum status: { pending: 0, approved: 1, rejected: 2, returned: 3 }
end
