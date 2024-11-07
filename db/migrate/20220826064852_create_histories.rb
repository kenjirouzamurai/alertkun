class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.references :site
      t.boolean :result, comment: "結果"
      t.string :message, comment: "エラーメッセージ"
      t.float :response_time, comment: "応答時間"

      t.timestamps
    end
  end
end
