class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.belongs_to   :user
      t.belongs_to   :article
      t.text         :body,    null: false
      t.timestamps
    end
  end
end
