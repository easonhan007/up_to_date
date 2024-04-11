class AddImageKeywordToCrawlerSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :crawler_settings, :image_keyword, :string
  end
end
