class InsurancePlans < ActiveRecord::Base
    def self.get_insurance_plans_by_provider insurance_provider
        plans = InsurancePlans.where(company_name: insurance_provider)
        plan_names = plans.pluck(:insurance_plan_name)
        insurance_plans = plan_names.map{ |str| str.upcase }
        return insurance_plans
    end
end