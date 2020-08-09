class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, default: "", null: false
      t.integer :last_user, default: 0, null: false
      t.boolean :is_borrow, default: false, null: false
      t.text :note

      t.timestamps
    end
  end
end
