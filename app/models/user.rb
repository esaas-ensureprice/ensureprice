class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    has_many :doctors
    has_many :doctor_reviews, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :upvoted_answers, through: :votes, source: :answer

    has_many :answers, dependent: :destroy
    has_many :answered_questions, through: :answers, source: :questions

    def self.get_username user_id
        return User.find(user_id)[:name]
    end
end