# To delete
def log_test(message)
    Rails.logger.info(message)
    puts message
end

class Doctors < ActiveRecord::Base
    def self.get_doctors_by_provider insurance_provider
        doc = Doctors.where(insurance_plan: insurance_provider)
        log_test(doc)
        return Doctors.where(insurance_plan: insurance_provider).pluck(:doctor_name)
    end
end