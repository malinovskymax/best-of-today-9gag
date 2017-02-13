class ImprovePosts < ActiveRecord::Migration
  def change
    rename_column :posts, :link, :post_link
    add_column :posts, :preview_link, :string
  end
end
