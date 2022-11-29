require 'rails_helper'

RSpec.describe EnsurepricesController, :type => :controller do
    let(:valid_attributes) {
        {
            name: "name",
            email: "email@gmail.com",
            password: "Password Digest",
            password_confirmation: "Password Digest",
        }
    }
    let!(:user1) { User.create! valid_attributes }

    let!(:insurance_plan1) {FactoryBot.create(:insurance_plan, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')}
    let!(:insurance_plan2) {FactoryBot.create(:insurance_plan, company_name: 'Company2', insurance_plan_name: 'PLAN2', uc: '40')}
    let!(:insurance_plan3) {FactoryBot.create(:insurance_plan, company_name: 'Company1', insurance_plan_name: 'PLAN3')}

    let!(:doctor1) {FactoryBot.create(:doctor, doctor_name: 'Dr. Yukti', insurance_plan: "Company1")}
    let!(:doctor2) {FactoryBot.create(:doctor, doctor_name: 'Dr. Jo', insurance_plan: "Company1")}
    let!(:doctor3) {FactoryBot.create(:doctor, doctor_name: 'Dr. Muhan', insurance_plan: "Company2")}

    before do
        # logging the user in 
        session[:user_id] = user1.id
    end

    describe 'GET #index' do
        it 'redirects to the root path' do
            get :index
            expect(response).to redirect_to(root_path)
        end
    end
      
    describe 'GET #show' do
        it 'assigns @insurance providers correctly' do
            get :show, id: insurance_plan1.id
            expected_result = ['Company1', 'Company2']
            expect(assigns(:insurance_providers)).to eq(expected_result)
        end

        it 'renders the show template' do
            get :show, id: insurance_plan1.id
            expect(response).to have_http_status(:ok)
            expect(response).to render_template('show')
        end
    end

    describe 'GET #plans' do
        it 'assigns insurance plans correctly' do
            @request.session[:id] = insurance_plan1.company_name
            get :plans, id: insurance_plan1.company_name
            
            expected_result = [insurance_plan1.insurance_plan_name, insurance_plan3.insurance_plan_name]
            expect(assigns(:insurance_plans)).to eq(expected_result)
        end

        it 'renders the plans template' do
            get :plans, id: insurance_plan1.company_name
            expect(response).to have_http_status(:ok)
            expect(response).to render_template('plans')
        end
    end

    describe 'GET #network_doctors' do
        it 'assigns doctors correctly' do 
            @request.session[:id] = insurance_plan1.company_name
            get :network_doctors, id: insurance_plan1.insurance_plan_name
            
            expected_result = [doctor1, doctor2]
            expect(assigns(:doctors)).to eq(expected_result)
        end

        it 'renders the doctors template' do
            get :network_doctors, id: insurance_plan1.insurance_plan_name
            expect(response).to have_http_status(:ok)
            expect(response).to render_template(:network_doctors)
        end
    end

    describe 'GET #visits' do
        it 'renders the visit types template' do
            get :visits, id: doctor1.doctor_name
            expect(response).to have_http_status(:ok)
            expect(response).to render_template('visits')
        end
    end

    describe 'GET #price' do
        it 'assigns price, deductible, and dollarSign variables correctly for coinsurance' do
            @request.session[:id] = insurance_plan1.company_name
            @request.session[:plan_id] = insurance_plan1.insurance_plan_name
            @request.session[:doctor_name] = doctor1.doctor_name
            @request.session[:visit_type] = 'OV'
            get :price, id: 'OV'

            expect(assigns(:price)).to eq('30% of the Total Bill')
            expect(assigns(:deductible)).to eq('5000')
            expect(assigns(:dollarSign)).to eq('')
        end

        it 'assigns price, deductible, and dollarSign variables correctly for copay' do
            @request.session[:id] = insurance_plan2.company_name
            @request.session[:plan_id] = insurance_plan2.insurance_plan_name
            @request.session[:doctor_name] = doctor3.doctor_name
            @request.session[:visit_type] = 'UC'
            get :price, id: 'UC'

            expect(assigns(:price)).to eq('40')
            expect(assigns(:deductible)).to eq('3000')
            expect(assigns(:dollarSign)).to eq('$')
        end

        it 'renders the price template' do
            @request.session[:id] = insurance_plan1.company_name
            @request.session[:plan_id] = insurance_plan1.insurance_plan_name
            @request.session[:doctor_name] = doctor1.doctor_name
            @request.session[:visit_type] = 'OV'
            get :price, id: 'OV'
            
            expect(response).to have_http_status(:ok)
            expect(response).to render_template('price')
        end
    end

    describe 'GET #logged_in_user' do
        context 'when user is not logged in' do
            before do
                session[:user_id] = nil
            end

            it 'sets the danger flash' do
                get :show, id: insurance_plan1.id
                expect(flash[:danger]).to be_present
                expect(flash[:danger]).to eq('Please log in.')
            end

            it 'redirects to login_path' do
                get :show, id: insurance_plan1.id
                expect(response).to redirect_to(login_path)
            end
        end
    
        context "when user is logged in" do
          it "redirects to login_path" do
            get :show, id: insurance_plan1.id
            expect(response).to be_success
          end
        end
    end
end