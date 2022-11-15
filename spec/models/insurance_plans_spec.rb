require 'rails_helper'

RSpec.describe InsurancePlans do
  describe '.get_insurance_plans_by_provider' do
    it 'get insurance plans by provider' do
      insurance_plan1 = FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')
      result = InsurancePlans.get_insurance_plans_by_provider(insurance_plan1.company_name)
      expect(result).to eq([insurance_plan1.insurance_plan_name])
    end
  end
end