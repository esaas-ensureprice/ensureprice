require 'rails_helper'

RSpec.describe DoctorsController, :type => :controller do

  let(:valid_attributes) {
    {
      name: "name",
      email: "email@gmail.com",
      password: "Password Digest",
      password_confirmation: "Password Digest",
    }
  }
  let!(:user1) { User.create! valid_attributes }

  let!(:insurance_plan1) {FactoryBot.create(:insurance_plans, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')}
  let!(:review1) {FactoryBot.create(:doctor_reviews, doctor_id: 1, doctor_name: 'Dr. Yukti')}
  let!(:doctor1) {FactoryBot.create(:doctors, doctor_name: 'Dr. Yukti', insurance_plan: "Company1")}

  before do
    # logging the user in
    session[:user_id] = user1.id
  end

  describe 'GET #index' do
    it 'assigns the doctors variable correctly' do
      get :index
      expect(assigns(:doctors)).to eq(Doctors.all)
    end
    
    it 'renders the index template' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('index')
    end

  end

  describe 'GET #show' do
    it 'assigns the doctors variable correctly' do
      get :show, id: doctor1.id
      expect(assigns(:doctor)).to have_attributes(:doctor_name => "Dr. Yukti", :insurance_plan => "Company1")
    end

    it 'renders the show template' do
      get :show, id: doctor1.id
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('show')

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

      it 'redirects to the login_path' do
        get :show, id: insurance_plan1.id
        expect(response).to redirect_to(login_path)
      end
    end

    context "when user is logged in" do
      it "redirects the user to login_path" do
        get :show, id: insurance_plan1.id
        expect(response).to be_success
      end
    end
  end

end