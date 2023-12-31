class Task < ApplicationRecord
    has_one_attached :eyecatch

    validates :title, presence: true
    validates :content, presence: true
    validates :date, presence: true

    belongs_to :user
    belongs_to :board
    has_many :comments

    def comment_count
        comments.count
    end
end
