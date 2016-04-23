class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :group_id
      t.string :user
      t.string :context

      t.timestamps
    end

    add_index :conversations, :group_id
    add_index :conversations, :updated_at
  end
end
