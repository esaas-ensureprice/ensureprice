require 'rails_helper'

RSpec.describe Doctors do
  describe '.get_in_network_doctors' do
    it 'gets doctors who accept an insurance provider' do
      insurance_plan1 = FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')
      doctor1 = FactoryBot.create(:doctors, doctor_name: 'Dr. Yukti', insurance_plan: "Company1")
      doctor2 = FactoryBot.create(:doctors, doctor_name: 'Dr. Jo', insurance_plan: "Company1")
      doctor3 = FactoryBot.create(:doctors, doctor_name: 'Dr. Muhan', insurance_plan: "Company2")

      result = Doctors.get_in_network_doctors(insurance_plan1.company_name)
      expect(result).to eq([doctor1, doctor2])
    end
  end
end