require 'rails_helper'

describe EnsurepricesController, :type => :controller do
  let!(:insurance_plan1) {FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'Plan1', individual_annual_deductible: '5000')}
  let!(:insurance_plan2) {FactoryBot.create(:insurance_plans, company_name: 'Company2', insurance_plan_name: 'Plan2', uc: '40')}

  describe 'GET show' do
    it 'should render the show template' do
        get :show, id: insurance_plan1.id
        expect(response).to render_template('show')
    end
  end
end