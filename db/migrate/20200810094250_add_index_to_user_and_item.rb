class AddIndexToUserAndItem < ActiveRecord::Migration[6.0]
  def change
    # indexを自動で追加してくれる
    add_reference :users, :group, foreign_key: true
    add_reference :items, :group, foreign_key: true
  end
end
