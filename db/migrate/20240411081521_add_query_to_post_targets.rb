class AddQueryToPostTargets < ActiveRecord::Migration[7.1]
  def change
    add_column :post_targets, :query, :string
  end
end
