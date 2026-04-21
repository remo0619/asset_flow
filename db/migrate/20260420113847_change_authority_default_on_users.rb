class ChangeAuthorityDefaultOnUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :authority, from: nil, to: 0
    change_column_null :users, :authority, false, 0
  end
end
