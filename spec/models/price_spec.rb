require 'rails_helper'

RSpec.describe Price do
  describe ".get_price_by_insurance_plan" do
    it "get price by insurance plan" do
      insurance_plan1 = FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')
      result = Price.get_price_by_insurance_plan(insurance_plan1.insurance_plan_name, "OV")
      expect(result).to eq(["30% of the Total Bill", "5000", ""])
    end
  end

  describe ".isCoinsurance" do
    it "determines the price is coinsurance" do
      result = Price.isCoinsurance("30%")
      expect(result).to be_truthy
    end

    it "determines the price is not coinsurance" do
      result = Price.isCoinsurance("30")
      expect(result).to be_falsey
    end
  end
end