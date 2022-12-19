require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  let(:valid_attributes) {
    {
      name: "name",
      email: "email@gmail.com",
      password: "Password Digest",
      password_confirmation: "Password Digest",
    }
  }
  let!(:user1) { User.create! valid_attributes }

  let(:question_attributes) {
    {
      ques: "convenient location?",
      asked_by: user1.id
    }
  }
  let!(:question1) { Question.create! question_attributes}

  before do
    # logging the user in
    session[:user_id] = user1.id
  end

  describe 'GET #index' do

    it 'assigns the questions variable correctly' do
      get :index
      expect(assigns(:questions)).to eq [question1]
    end

    it 'searches for my questions' do
      @request.params[:my_ques] = true
      @request.session[:user_id] = 1
      get :index, id: user1.id
      expect(assigns(:questions)).to eq [question1]
    end

  end

  describe 'GET #new' do
    it 'gets a new question' do
      get :new
      expect(assigns(:question)).to have_attributes(:id => nil)
    end

  end

  describe 'POST #create' do

    it 'creates a new question filled with attributes' do
      @request.params[:question] = question_attributes
      post :create, question: question_attributes
    end

    it 'creates a new question' do
      @request.session[:user_id] = 1000
      post :create, question: question_attributes

    end

  end

  #describe 'GET #ques_answers' do

  #it 'filters my answers' do
  #get :ques_answers
  #expect(assigns(:answers)).to have_attributes(:id => nil)
  #end

  #end

  describe 'POST #edit' do
    before do
      post :edit, id: question1.id
    end

    it 'renders the edit template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('edit')
    end

    it 'assigns @question using id' do
      expect(assigns(:question)).to eq question1
    end

  end

  #describe 'PATCH #update' do
  #it 'updates the question' do
  #patch :update
  #end
  #end

  describe 'DELETE #destroy' do
    it "destroys the requested question" do
      expect {
        delete :destroy, id: question1.id
      }.to change(Question, :count).by(-1)
    end

    it "sets the success flash" do
      delete :destroy, id: question1.id
      expect(flash[:success]).to be_present
      expected_msg = "Question was deleted successfully."
      expect(flash[:success]).to eq(expected_msg)
    end

    it "re-renders the questions path" do
      delete :destroy, id: question1.id
      expect(response).to redirect_to(questions_path)
    end
  end
end