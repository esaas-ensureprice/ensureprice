require 'rails_helper'
require 'spec_helper'

#Delete
def log_test(message)
  Rails.logger.info(message)
  puts message
end

RSpec.describe EnsurepricesController, :type => :controller do
  let!(:insurance_plan1) {FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')}
  let!(:insurance_plan2) {FactoryBot.create(:insurance_plans, company_name: 'Company2', insurance_plan_name: 'PLAN2', uc: '40')}
  let!(:insurance_plan3) {FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'PLAN3')}

  let!(:doctor1) {FactoryBot.create(:doctors, doctor_name: 'Dr. Yukti', insurance_plan: "Company1")}
  let!(:doctor2) {FactoryBot.create(:doctors, doctor_name: 'Dr. Jo', insurance_plan: "Company1")}
  let!(:doctor3) {FactoryBot.create(:doctors, doctor_name: 'Dr. Muhan', insurance_plan: "Company2")}
      
  describe 'GET show' do
    it 'should assign insurance providers variable correctly' do
      get :show, id: insurance_plan1.id
      expected_result = ['Company1', 'Company2']
      expect(assigns(:insurance_providers)).to eq(expected_result)
    end

    it 'should render the show template' do
      get :show, id: insurance_plan1.id
      expect(response).to render_template('show')
    end
  end

  describe 'GET plans' do
    it 'should assign insurance plans correctly' do
      get :plans, id: insurance_plan1.company_name
      request.session[:id] = "Company1"
      expected_result = [insurance_plan1.insurance_plan_name, insurance_plan3.insurance_plan_name]
      expect(assigns(:insurance_plans)).to eq(expected_result)
    end

    it 'should render the plans template' do
      get :plans, id: insurance_plan1.company_name
      expect(response).to render_template('plans')
    end
  end

  describe 'GET plans' do
    it 'should assign insurance plans correctly' do
      get :plans, id: insurance_plan1.company_name
      request.session[:id] = insurance_plan1.company_name
      expected_result = [insurance_plan1.insurance_plan_name, insurance_plan3.insurance_plan_name]
      expect(assigns(:insurance_plans)).to eq(expected_result)
    end

    it 'should render the plans template' do
      get :plans, id: insurance_plan1.company_name
      expect(response).to render_template('plans')
    end
  end

  describe 'GET doctors' do
    # DELETE
    # it 'should assign doctors correctly' do
    #   get :doctors, id: insurance_plan1.insurance_plan_name
    #   request.session[:id] = insurance_plan1.company_name
    #   expected_result = [doctor1.doctor_name, doctor2.doctor_name]
    #   expect(assigns(:doctors)).to eq(expected_result)
    # end

    it 'should render the doctors template' do
      get :doctors, id: insurance_plan1.insurance_plan_name
      expect(response).to render_template('doctors')
    end
  end

  describe 'GET visit types' do
    it 'should render the visit types template' do
      get :visits, id: doctor1.doctor_name
      expect(response).to render_template('visits')
    end
  end

  describe 'GET price' do
    it 'should render the price template' do
      log_test("hi")
      get :price, id: 'OV'
      @request.session['id'] = insurance_plan1.company_name
      @request.session[:plan_id] = insurance_plan1.insurance_plan_name
      @request.session[:doctor_name] = doctor1.doctor_name
      @request.session[:visit_type] = 'OV'

      
      #expect(response).to render_template('price')
      #expect(page).to have_content('%')
      #expect(page).not_to have_content('$')
    end
  end
end