class ArticlesSerializer < ActiveModel::Serializer

# t.belongs_to :user
# t.string     :title,            null: false
# t.text       :body,             null: false
# t.string     :category
# t.date       :publication_date

  attributes :id,
             :user_id,
             :user_email,
             # :title,
             # :short_body,
             # :category,
             # :publication_date,
             :comments_count


  def user_email
   object.user.email
  end

  def short_body
    if object.body.length > 500
      object.body.truncate(500)
    else
      object.body
    end
  end

  def comments_count
    object.comments.count
  end

  # has_many :comments
end
