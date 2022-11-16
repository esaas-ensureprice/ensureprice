class DoctorReviews < ActiveRecord::Base
    validates :review_title,  presence: true, length: { maximum: 70 }
    validates :user_review,  presence: true
end
