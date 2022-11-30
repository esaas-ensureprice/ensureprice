class Doctor < ActiveRecord::Base
    has_many :doctor_reviews
    
    def self.get_in_network_doctors insurance_provider
        return Doctor.where(insurance_plan: insurance_provider)
    end

    def self.compute_rating doctor
        all_ratings = DoctorReview.where(doctor_id: doctor.id).pluck(:rating)
        return 0 if all_ratings.empty?
        average_rating = all_ratings.reduce(:+).to_f / all_ratings.size
        return average_rating.round(2), all_ratings.size
    end
end