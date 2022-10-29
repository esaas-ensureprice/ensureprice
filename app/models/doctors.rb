#To delete
    def log_test(message)
        Rails.logger.info(message)
        puts message
    end

class Doctors < ActiveRecord::Base
    def self.get_doctors_by_plan insurance_plan
        doc = Doctors.where(insurance_plan: insurance_plan)
        log_test(doc)
        return Doctors.where(insurance_plan: insurance_plan).pluck(:doctor_name)
    end
end