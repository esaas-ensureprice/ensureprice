class DoctorReviews < ActiveRecord::Base
    validates :user_review,  presence: true, length: { maximum: 50 }
    validates :review_title,  presence: true, length: { maximum: 150 }
end
