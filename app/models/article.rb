class Article < ApplicationRecord
  default_scope { order(publication_date: :desc) }

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true


  belongs_to :user
  has_many   :comments, dependent: :destroy

  scope :old, -> { where('created_at < ?', 6.days.ago )}

end
