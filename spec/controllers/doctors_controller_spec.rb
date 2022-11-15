require 'rails_helper'
require 'spec_helper'

RSpec.describe DoctorsController, :type => :controller do
  let!(:doctor1) {FactoryBot.create(:doctors, doctor_name: 'Dr. Yukti', insurance_plan: "Company1")}
  let!(:doctor2) {FactoryBot.create(:doctors, doctor_name: 'Dr. Jo', insurance_plan: "Company1")}
  let!(:doctor3) {FactoryBot.create(:doctors, doctor_name: 'Dr. Muhan', insurance_plan: "Company2")}

  describe 'GET show' do
    it 'should assign doctors variable correctly' do
      get :show, id: doctor1.id
      expect(assigns(:doctor)).to have_attributes(:doctor_name => "Dr. Yukti", :insurance_plan => "Company1")
    end

    it 'should render the show template' do
      get :show, id: doctor1.id
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('show')

    end


  end
end
