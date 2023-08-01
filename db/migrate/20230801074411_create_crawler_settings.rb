class CreateCrawlerSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :crawler_settings do |t|
      t.string :name
      t.string :index_page_url
      t.string :index_page_css
      t.string :detail_page_title_css
      t.string :detail_page_content_css
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
