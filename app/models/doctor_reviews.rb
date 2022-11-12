class DoctorReviews < ActiveRecord::Base
    def self.get_doctor_info doctor_id
        info = Doctors.find(doctor_id)
        return info
    end
end