class DoctorReview < ActiveRecord::Base
    belongs_to :user
    belongs_to :doctor
    validates :review_title,  presence: true, length: { maximum: 70 }
    validates :user_review,  presence: true
    validates :rating, numericality: { in: 1..5 }

    # def update_average_rating(review=nil)
    #     avg_rating, count_rating = Doctor.compute_rating self
    #     puts("HELOOOO")
    #     puts(avg_rating)
    #     self.update_attribute(:rating, avg_rating.nil ? 0.0 : avg_rating)
    # end
end
