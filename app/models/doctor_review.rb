class DoctorReview < ActiveRecord::Base
    belongs_to :user
    belongs_to :doctor
    validates :review_title,  presence: true, length: { maximum: 70 }
    validates :user_review,  presence: true
    validates :rating, numericality: { in: 1..5 }
end
