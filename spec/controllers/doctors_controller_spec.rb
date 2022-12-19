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

  let!(:insurance_plan1) {FactoryBot.create(:insurance_plan, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')}
  let!(:review1) {FactoryBot.create(:doctor_review, doctor_id: 1, doctor_name: 'Dr. Yukti')}
  let!(:doctor1) {FactoryBot.create(:doctor, doctor_name: 'Dr. Yukti', insurance_plan: "Company1")}

  before do
    # logging the user in
    session[:user_id] = user1.id
  end

  describe 'GET #index' do
    let!(:doctor2) { FactoryBot.create(:doctor, doctor_name: 'Lily Lawrence', insurance_plan: 'Aetna', designation: 'MD', specialty: 'Cardiologist', avg_rating: 4) }
    let!(:doctor3) { FactoryBot.create(:doctor, doctor_name: 'Jenny Gerner', insurance_plan: 'Aetna', designation: 'MD', specialty: 'Gastroenterologist', avg_rating: 2) }
    let!(:doctor4) { FactoryBot.create(:doctor, doctor_name: 'Omar Hawasli', insurance_plan: 'Empire', designation: 'MBBS', specialty: 'Cardiologist', avg_rating: 5) }

    it 'assigns the doctors variable correctly' do
      get :index
      expect(assigns(:doctors)).to eq(Doctor.all.limit(500))
    end

    it 'returns the doctors filtered by insurance plan, designation and specialty if filter is applied' do
      get :index, insurance_plan: 'Aetna', designation: 'MD', specialty: 'Cardiologist'
      expect(assigns(:doctors)).to match_array([doctor2])
    end

    it 'returns the doctors sorted by average rating if sort_by is present in params' do
      get :index, sort: 'avg_rating'
      expect(assigns(:doctors)).to eq([doctor4, doctor2, doctor3, doctor1])
    end

    it 'returns the doctors based on search query' do
      get :index, query: 'gerner'
      expect(assigns(:doctors)).to eq([doctor3])
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