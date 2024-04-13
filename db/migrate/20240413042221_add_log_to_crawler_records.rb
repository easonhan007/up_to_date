class AddLogToCrawlerRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :crawler_records, :log, :text
  end
end
