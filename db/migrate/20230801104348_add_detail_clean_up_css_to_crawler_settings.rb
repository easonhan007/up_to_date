class AddDetailCleanUpCssToCrawlerSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :crawler_settings, :detail_page_clean_up_css, :text
  end
end
