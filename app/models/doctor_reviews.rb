class DoctorReviews < ActiveRecord::Base
    def self.get_doctor_info doctor_id
        return Doctors.find(doctor_id)
    end
end