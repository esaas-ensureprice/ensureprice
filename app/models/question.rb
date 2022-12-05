class Question < ActiveRecord::Base
    belongs_to :user
    has_many :answers, dependent: :destroy
    has_many :answered_users, through: :answers, source: :user
end
