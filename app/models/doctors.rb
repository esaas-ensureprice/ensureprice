class Doctors < ActiveRecord::Base
    def self.get_in_network_doctors insurance_provider
        return Doctors.where(insurance_plan: insurance_provider)
    end

    def self.with_insurance_plans(plans_list)
        Doctors.where(insurance_plan: plans_list)
    end

    def self.get_doctors_by_provider insurance_provider
        #doc = Doctors.where(insurance_plan: insurance_provider)
        return Doctors.where(insurance_plan: insurance_provider).pluck(:doctor_name).uniq
    end
end