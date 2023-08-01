class CreateCrawlerRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :crawler_records do |t|
      t.integer :url_count
      t.integer :success
      t.integer :failed
      t.text :urls
      t.references :crawler_setting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
