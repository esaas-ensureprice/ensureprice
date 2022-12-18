require 'rails_helper'
require 'date'

RSpec.describe AnswersController, :type => :controller do

  let(:valid_attributes) {
    {
      name: "name",
      email: "email@gmail.com",
      password: "Password Digest",
      password_confirmation: "Password Digest",
    }
  }
  let!(:user1) { User.create! valid_attributes }

  let(:answer_attributes) {
    {
      question_id: 1,
      answer: "good doc",
      answered_by: user1.id
    }
  }
  let!(:answer1) { Answer.create! answer_attributes}

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

  describe 'GET #new' do


    it 'gets a new answer' do
      @request.params[:question_id] = question1.id
      get :new, answer: answer1, question_id: question1.id
      expect(assigns(:answer)).to have_attributes(:id => nil)
    end


  end

  describe 'POST #create' do

    it 'creates a new answer filled with attributes' do
      @request.params[:question_id] = question1.id
      post :create, answer: answer_attributes, question_id: question1.id
    end

  end

  describe 'POST #edit' do
    before do
      post :edit, id: answer1.id
    end

    it 'renders the edit template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('edit')
    end

    it 'assigns @answer using id' do
      expect(assigns(:answer)).to eq answer1
    end

  end

  describe 'DELETE #destroy' do
    it "destroys the requested answer" do
      expect {
        delete :destroy, id: answer1.id
      }.to change(Answer, :count).by(-1)
    end

    it "sets the success flash" do
      delete :destroy, id: answer1.id
      expect(flash[:success]).to be_present
      expected_msg = "Answer was deleted successfully."
      expect(flash[:success]).to eq(expected_msg)
    end

    #it "re-renders the questions path" do
    #delete :destroy, id: answer1.id
    #expect(response).to redirect_to(ques_answers_path)
    #end
  end

  #describe 'GET #upvote' do
  #it 'upvotes the answer' do
  #get :upvote
  #end

  #end

end