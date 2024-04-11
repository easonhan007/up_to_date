class AddNameToPostTarget < ActiveRecord::Migration[7.1]
  def change
    add_column :post_targets, :name, :string
  end
end
