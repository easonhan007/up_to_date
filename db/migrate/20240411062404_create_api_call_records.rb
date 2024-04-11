class CreateApiCallRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :api_call_records do |t|
      t.integer :post_id
      t.integer :post_target_id
      t.integer :status_code
      t.text :log
      t.integer :user_id

      t.timestamps
    end
  end
end
