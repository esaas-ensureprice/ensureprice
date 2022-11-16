require 'rails_helper'

RSpec.describe Price do
  describe '.get_price_by_insurance_plan' do
    it 'gets price by insurance plan for coinsurance' do
      insurance_plan1 = FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')
      result = Price.get_price_by_insurance_plan(insurance_plan1.insurance_plan_name, 'OV')
      expect(result).to eq(['30% of the Total Bill', '5000', ''])
    end

    it 'gets price by insurance plan for copay' do
      insurance_plan2 = FactoryBot.create(:insurance_plans, company_name: 'Company2', insurance_plan_name: 'PLAN2')
      result = Price.get_price_by_insurance_plan(insurance_plan2.insurance_plan_name, 'SPC')
      expect(result).to eq(['100', '3000', '$'])
    end
  end

  describe '.isCoinsurance' do
    it 'determines the price is coinsurance' do
      result = Price.isCoinsurance('30%')
      expect(result).to be_truthy
    end

    it 'determines the price is not coinsurance' do
      result = Price.isCoinsurance('30')
      expect(result).to be_falsey
    end
  end
end