class CreateSites < ActiveRecord::Migration[7.0]
  def change
    create_table :sites do |t|
      t.references :user
      t.string :name, null: false, comment: "サイト名"
      t.string :domain, null: false
      t.integer :timeout, default: 10, comment: "タイムアウト"

      t.timestamps
    end
  end
end
