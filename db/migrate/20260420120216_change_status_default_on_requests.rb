class ChangeStatusDefaultOnRequests < ActiveRecord::Migration[7.2]
  def change
    change_column_default :requests, :status, from: nil, to: 0
    change_column_null :requests, :status, false, 0
  end
end
