class InsurancePlans < ActiveRecord::Base
    def self.get_insurance_plans_by_provider insurance_provider
        return InsurancePlans.where(company_name: insurance_provider).pluck(:insurance_plan_name)
    end
end