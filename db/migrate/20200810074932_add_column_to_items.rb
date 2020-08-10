class AddColumnToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :user, foreign_key: true
    add_index :items, [:user_id, :updated_at] #複合キーインデックスの作成
  end
end
