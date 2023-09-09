class AddWeightToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :weight, :integer, default: 0
  end
end
