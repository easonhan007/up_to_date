class AlterCategoryIdOfCrawlerSetting < ActiveRecord::Migration[7.0]
  def change
    change_column_null :crawler_settings, :category_id, true
  end
end
