class Answer < ActiveRecord::Base
    belongs_to :question
    belongs_to :user
    has_many :votes, dependent: :destroy
    has_many :upvoted_users, through: :votes, source: :user
    validates_uniqueness_of :question_id, scope: :answered_by
    validates :answer,  presence: true
end
