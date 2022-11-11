class Doctors < ActiveRecord::Base
    def self.get_doctors_by_provider insurance_provider
        return Doctors.where(insurance_plan: insurance_provider).pluck(:doctor_name).uniq
    end

    def self.get_doctors insurance_provider
        return Doctors.where(insurance_plan: insurance_provider)
    end
end