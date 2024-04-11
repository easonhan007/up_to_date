class AddSlugImageUrlToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :slug, :string
    add_column :posts, :image_url, :string
  end
end
