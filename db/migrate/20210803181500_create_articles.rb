class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.belongs_to :user
      t.string     :title,            null: false
      t.text       :body,             null: false
      t.string     :category
      t.date       :publication_date

      t.timestamps
    end
  end
end
