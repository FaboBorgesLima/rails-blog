class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :title, null: false, index: { unique: true }
      t.string :description, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.text :content

      t.timestamps
    end
  end
end
