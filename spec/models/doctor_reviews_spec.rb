require 'rails_helper'

RSpec.describe DoctorReviews, type: :model do
  describe '.get_my_reviews' do
    it 'get_my_reviews' do
      #insurance_plan1 = FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')
      review1 = FactoryBot.create(:doctor_reviews)
      #doctor2 = FactoryBot.create(:doctors, doctor_name: 'Dr. Jo', insurance_plan: "Company1")
      #doctor3 = FactoryBot.create(:doctors, doctor_name: 'Dr. Muhan', insurance_plan: "Company2")

      result = DoctorReviews.get_my_reviews(nil)
      expect(result).to eq(nil)

      result = DoctorReviews.get_my_reviews(1)
      expect(result).to eq(review1)

    end
  end
end
