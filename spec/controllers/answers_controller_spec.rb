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
  let!(:question1) { Question.create! question_attributes }

  before do
    # logging the user in
    session[:user_id] = user1.id
  end

  describe 'GET #new' do
    before do
      @request.params[:question_id] = question1.id
      get :new, answer: answer1, question_id: question1.id
    end

    it "assigns @question with question having given id" do
      expect(assigns(:question)).to eq(question1)
    end

    it 'creates empty new answer for the given question' do
      expect(assigns(:answer)).to have_attributes(:answer => nil)
    end

    it 'renders the new template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    let!(:answer1) { FactoryBot.attributes_for(:answer, question_id: question1.id) }
    let!(:invalid_answer) {FactoryBot.attributes_for(:answer, question_id: question1.id, answer: "")}

    context 'with valid answer' do
      it "creates a new answer" do
        expect {
          post :create, answer: answer1, question_id: question1.id
        }.to change(Answer, :count).by(1)
      end
  
      it 'sets the success flash' do
        post :create, answer: answer1, question_id: question1.id
        expect(flash[:success]).to be_present
        expected_msg = "Answer submitted successfully."
        expect(flash[:success]).to eq(expected_msg)
      end
  
      it "redirects to the questions page" do
        post :create, answer: answer1, question_id: question1.id
        expect(response).to redirect_to questions_path
      end
    end

    context 'with invalid answer' do
      it "does not create a new answer" do
        expect {
          post :create, answer: invalid_answer, question_id: question1.id
        }.to_not change(Answer, :count)
      end

      it 'sets the danger flash' do
        post :create, answer: invalid_answer, question_id: question1.id
        expect(flash[:danger]).to be_present
        expected_msg = "Submit Failed! You might have already submitted an answer to this question."
        expect(flash[:danger]).to eq(expected_msg)
      end

      it "renders the new page" do
        post :create, answer: invalid_answer, question_id: question1.id
        expect(response).to render_template :new
      end
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
      expect(assigns(:answer)).to eq(answer1)
    end
  end

  describe 'PATCH #update' do
    let!(:valid_answer) { FactoryBot.attributes_for(:answer, question_id: question1.id, answer: "Modified Answer") }
    let!(:invalid_answer) {FactoryBot.attributes_for(:answer, question_id: question1.id, answer: "")}

    context 'when the user enters valid answer' do
      it 'assigns the requested answer to @answer' do
        patch :update, id: answer1.id, answer: valid_answer
        expect(assigns(:answer)).to eq answer1
      end

      it 'changes @answer' do
        patch :update, id: answer1.id, answer: valid_answer
        answer1.reload
        expect(answer1.answer).to eq('Modified Answer')
      end

      it "sets the success flash" do
        patch :update, id: answer1.id, answer: valid_answer
        expect(flash[:success]).to be_present
        expected_msg = "Answer updated successfully."
        expect(flash[:success]).to eq(expected_msg)
      end

      it 'redirects to the answers page for that question after updating answer' do
        patch :update, id: answer1.id, answer: valid_answer
        expect(response).to redirect_to ques_answers_path(question_id: answer1.question_id)
      end
    end

    context 'when the user enters invalid answer' do
      it 'does not change the answer' do
        patch :update, id: answer1.id, answer: invalid_answer
        answer1.reload
        expect(answer1.answer).to_not eq("")
      end

      it 're-renders the #edit template' do
        patch :update, id: answer1.id, answer: invalid_answer
        expect(response).to render_template :edit
      end
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

    it 'redirects to question answers page' do
      delete :destroy, id: answer1.id
      expect(response).to redirect_to ques_answers_path(question_id: answer1.question_id)
    end
  end

  describe 'POST #upvote' do
    context "when answer is not voted by user already" do
      it "creates vote on the answer" do
        expect { post :upvote, id: answer1.id }.to change { answer1.votes.count }.by(1)
      end

      it "creates vote with user id" do
        post :upvote, id: answer1.id
        expect(answer1.votes.last.user_id).to eq(user1.id)
      end

      it "sets success flash" do
        post :upvote, id: answer1.id
        expect(flash[:success]).to be_present
        expected_msg = "Thank you for upvoting!"
        expect(flash[:success]).to eq(expected_msg)
      end

      it "redirects to answers path" do
        post :upvote, id: answer1.id
        expect(response).to redirect_to ques_answers_path(question_id: answer1.question_id)
      end
    end

    context "when answer is voted by user already" do
      before do 
        answer1.votes.create(user_id: user1.id) 
      end

      it "does not create a new vote on the answer" do
        expect { post :upvote, id: answer1.id }.not_to change { answer1.votes.count }
      end

      it "sets danger flash" do
        post :upvote, id: answer1.id
        expect(flash[:danger]).to be_present
        expected_msg = "You have already upvoted this!"
        expect(flash[:danger]).to eq(expected_msg)
      end

      it "redirects to answers path" do
        post :upvote, id: answer1.id
        expect(response).to redirect_to ques_answers_path(question_id: answer1.question_id)
      end
    end
  end

  describe 'GET #logged_in_user' do
    context 'when user is not logged in' do
      before do
        session[:user_id] = nil
        @request.params[:question_id] = question1.id
        get :new, answer: answer1, question_id: question1.id
      end

      it 'sets the danger flash' do
        expect(flash[:danger]).to be_present
        expected_msg = "Please log in."
        expect(flash[:danger]).to eq(expected_msg)
      end

      it "redirects user to login page" do
        expect(response).to redirect_to(login_path)
      end
    end

    context "when user is logged in" do
      it "returns a successful response" do
        @request.params[:question_id] = question1.id
        get :new, answer: answer1, question_id: question1.id
        expect(response).to be_successful
      end
    end
  end
end