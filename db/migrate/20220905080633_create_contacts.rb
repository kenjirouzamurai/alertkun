class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false, comment: "担当者名"
      t.string :company_name, comment: "会社名"
      t.string :email, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
