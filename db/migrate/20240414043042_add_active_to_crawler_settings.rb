class AddActiveToCrawlerSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :crawler_settings, :active, :boolean, default: false
  end
end
