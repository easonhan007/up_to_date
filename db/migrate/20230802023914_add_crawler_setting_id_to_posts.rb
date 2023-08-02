class AddCrawlerSettingIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :crawler_setting, null: false, foreign_key: true
  end
end
