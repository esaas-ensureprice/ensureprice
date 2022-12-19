class InsuranceProviderLogo < ActiveRecord::Base
    def self.get_logo_url insurance_provider
        record = InsuranceProviderLogo.find_by(company_name: insurance_provider)
        if !record.nil?
            record[:logo]
        else
            nil
        end
    end
end