class CreatePostTargets < ActiveRecord::Migration[7.1]
  def change
    create_table :post_targets do |t|
      t.string :api
      t.string :key
      t.text :headers, default: '{"Content-Type": "application/json"}'
      t.text :field_mapping
      t.integer :success_code, default: 200

      t.timestamps
    end
  end
end
