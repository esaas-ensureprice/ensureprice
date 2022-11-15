require 'rails_helper'

RSpec.describe Doctors do
  describe '.get_doctors_by_provider' do
    it 'get doctors by provider' do
      insurance_plan1 = FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')
      doctor1 = FactoryBot.create(:doctors, doctor_name: 'Dr. Yukti', insurance_plan: "Company1")
      doctor2 = FactoryBot.create(:doctors, doctor_name: 'Dr. Jo', insurance_plan: "Company1")
      doctor3 = FactoryBot.create(:doctors, doctor_name: 'Dr. Muhan', insurance_plan: "Company2")

      result = Doctors.get_doctors_by_provider(insurance_plan1.company_name)
      expect(result).to eq([doctor1.doctor_name,doctor2.doctor_name])
    end
  end


  describe '.with_insurance_plans' do
    it 'with_insurance_plans' do
      insurance_plan1 = FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')
      doctor1 = FactoryBot.create(:doctors, doctor_name: 'Dr. Yukti', insurance_plan: "Company1")
      doctor2 = FactoryBot.create(:doctors, doctor_name: 'Dr. Jo', insurance_plan: "Company1")
      doctor3 = FactoryBot.create(:doctors, doctor_name: 'Dr. Muhan', insurance_plan: "Company2")

      result = Doctors.with_insurance_plans(insurance_plan1.company_name)
      expect(result).to eq([doctor1,doctor2])
    end
  end

end