class DoctorReviews < ActiveRecord::Base
    validates :review_title,  presence: true, length: { maximum: 70 }
    validates :user_review,  presence: true

    #Obsolete
    #def self.get_my_reviews review_id
    #    if review_id.nil?
    #        return nil  
    #    else 
    #        return DoctorReviews.find(review_id)
    #    end
    #end
end
