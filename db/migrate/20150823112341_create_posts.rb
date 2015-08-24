class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :link
      t.integer :rating

      t.timestamps null: false
    end
  end
end
