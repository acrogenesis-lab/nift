class Review < ActiveRecord::Base

  RATING_VALUES = [1, 2, 3, 4, 5]

  validates :rating, presence: true, inclusion: {in: RATING_VALUES}
  validates :author_id, presence: true
  validates :product_id, presence: true
  validates_uniqueness_of :author_id, scope: :product_id

  belongs_to :author,
    class_name: 'User',
    foreign_key: :author_id
  belongs_to :product
  has_many :votes

end
