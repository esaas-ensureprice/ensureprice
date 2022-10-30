require 'rails_helper'

describe EnsurepricesController, :type => :controller do
  let!(:insurance_plan1) {FactoryBot.create(:insurance_plan, company_name: 'Company1', insurance_plan_name: 'Plan1', individual_annual_deductible: '5000')}
  let!(:insurance_plan2) {FactoryBot.create(:insurance_plan, company_name: 'Company2', insurance_plan_name: 'Plan2', uc: '40')}

  describe 'GET index' do
    it 'check' do
      get :index
      puts insurance_plan1.company_name
    end
  end
end