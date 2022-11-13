class Doctors < ActiveRecord::Base
    def self.get_in_network_doctors insurance_provider
        return Doctors.where(insurance_plan: insurance_provider)
    end
end