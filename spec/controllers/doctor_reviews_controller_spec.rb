require 'rails_helper'
require 'spec_helper'

RSpec.describe DoctorReviewsController, :type => :controller do

  let!(:review1) {FactoryBot.create(:doctor_reviews, doctor_id: 1, doctor_name: 'Dr. Yukti')}
  let!(:doctor1) {FactoryBot.create(:doctors, doctor_name: 'Dr. Yukti', insurance_plan: "Company1")}


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

  describe 'GET create' do
    # TODO
    it 'should render the new template' do
      @request.session[:id] = 1
      get :create, id: review1.doctor_id, doctor: doctor1,doctor_review: review1
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('create')
    end
  end

  describe 'GET edit' do
    it 'should assign @doctor_review' do
      get :edit, id: review1.doctor_id
      expect(assigns(:doctor_review)).to eq(review1)

    end
    it 'should render the edit template' do
      get :edit, id: review1.doctor_id
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

  describe 'GET destroy' do
    it 'should destroy review' do
      @request.params[:id] = 1
      get :destroy, id: review1.doctor_id

    end
  end

end