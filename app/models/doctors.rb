class Doctors < ActiveRecord::Base
    def self.get_in_network_doctors insurance_provider
        return Doctors.where(insurance_plan: insurance_provider)
    end

    def self.compute_rating doctor
        all_ratings = DoctorReviews.where(doctor_id: doctor.id).pluck(:rating)
        return 0 if all_ratings.empty?
        average_rating = all_ratings.reduce(:+).to_f / all_ratings.size
        return average_rating
    end
end