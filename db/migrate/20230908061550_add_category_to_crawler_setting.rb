class AddCategoryToCrawlerSetting < ActiveRecord::Migration[7.0]
  def change
    add_reference :crawler_settings, :category, null: false, foreign_key: true, default: 1
  end
end
