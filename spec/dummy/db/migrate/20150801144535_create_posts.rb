class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :client, index: true, foreign_key: true, null: false
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
