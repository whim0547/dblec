class DeleteIntFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :last_user, :integer
  end
end
