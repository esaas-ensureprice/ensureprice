require 'rails_helper'
require 'spec_helper'

RSpec.describe DoctorReviewsController, :type => :controller do

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

  describe 'GET new' do
    it 'should create empty new review' do
      @request.session[:id] = 1
      get :new, id: review1.id
      expect(assigns(:doctor_review)).to have_attributes(:doctor_id => nil)
    end
    it 'should render the new template' do
      @request.session[:id] = 1
      get :new, id: review1.doctor_id
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('new')
    end

  end

  describe 'POST create' do
    # TODO
    it 'should render the new template' do
      @request.session[:id] = 1
      post :create, id: review1.doctor_id, doctor: doctor1,doctor_review: review1
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('create')
    end
  end

  describe 'POST edit' do
    it 'should assign @doctor_review' do
      post :edit, id: review1.doctor_id
      expect(assigns(:doctor_review)).to eq(review1)

    end
    it 'should render the edit template' do
      post :edit, id: review1.doctor_id
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('edit')
    end
  end



  describe 'GET reviews' do
    it 'should find reviews' do
      @request.session[:id] = 1
      get :reviews, id: review1.doctor_id
    end
    it 'should render the reviews template' do
      @request.session[:id] = 1
      get :reviews, id: review1.doctor_id
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('reviews')
    end
  end

  describe 'POST destroy' do
    it 'should destroy review' do
      @request.params[:id] = 1
      post :destroy, id: review1.doctor_id

    end
  end

  describe 'GET #logged_in_user' do
    context 'when user is not logged in' do
      before do
        session[:user_id] = nil
      end

      it 'should set the danger flash' do
        get :show, id: insurance_plan1.id
        expect(flash[:danger]).to be_present
        expect(flash[:danger]).to eq('Please log in.')
      end

      it 'should redirect to login_path' do
        get :show, id: insurance_plan1.id
        expect(response).to redirect_to(login_path)
      end
    end

    context "when user is logged in" do
      it "should redirect to login_path" do
        get :show, id: insurance_plan1.id
        expect(response).to be_success
      end
    end
  end

end