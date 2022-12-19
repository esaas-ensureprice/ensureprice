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
    let!(:question2) { FactoryBot.create(:question, asked_by: 5) }
    let!(:question3) { FactoryBot.create(:question, ques: 'test question 3', asked_by: 6) }
    let!(:question4) { FactoryBot.create(:question, ques: 'test question 4', asked_by: user1.id) }

    it 'assigns the questions variable correctly' do
      get :index
      questions = [question4, question3, question2, question1]
      expect(assigns(:questions)).to eq(questions)
    end

    it "assigns @filter_my_ques when filter is applied" do
      get :index, my_ques: true
      expect(assigns(:filter_my_ques)).to eq(true)
    end

    context 'when filter by my_ques is present' do
      it 'assigns the requested questions to @questions' do
        get :index, my_ques: true
        questions = [question4, question1]
        expect(assigns(:questions)).to eq(questions)
      end
    end

    context 'when a search query is present' do
      it 'assigns the requested questions to @questions' do
        get :index, query: 'test'
        questions = [question4, question3]
        expect(assigns(:questions)).to eq(questions)
      end
    end
  end

  describe 'GET #new' do
    it 'gets a new question' do
      get :new
      expect(assigns(:question)).to have_attributes(:id => nil)
    end

    it 'renders the new template' do
      get :new
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    let!(:valid_question) { FactoryBot.attributes_for(:question) }
    let!(:invalid_question) {FactoryBot.attributes_for(:question, ques: "")}

    context 'with valid question' do
      it 'creates a new question' do
        expect {
          post :create, question: question_attributes
        }.to change(Question, :count).by(1)
        
      end

      it 'set the created question to correct user' do
        post :create, question: question_attributes
        expect(Question.last.asked_by).to eq(user1.id)
      end
  
      it 'sets the success flash' do
        post :create, question: question_attributes
        expect(flash[:success]).to be_present
        expected_msg = "Question submitted successfully."
        expect(flash[:success]).to eq(expected_msg)
      end
  
      it "redirects to the questions page" do
        post :create, question: question_attributes
        expect(response).to redirect_to(questions_path)
      end
    end

    context 'with invalid question' do
      it "does not create a new question" do
        expect {
          post :create, question: invalid_question
        }.to_not change(Question, :count)
      end

      it "renders the new page" do
        post :create, question: invalid_question
        expect(response).to render_template('new')
      end
    end
  end

  describe "GET #ques_answers" do
    let!(:question2) { FactoryBot.create(:question, ques: "Are Copay and Coinsurance the same?", asked_by: 5) }
    let!(:answer2) { FactoryBot.create(:answer, question_id: question2.id, answer: "Answer 1", answered_by: user1.id) }
    let!(:answer3) { FactoryBot.create(:answer, question_id: question2.id, answer: "Answer 2", answered_by: 4) }

    it "assigns @question using id" do
      get :ques_answers, question_id: question2.id
      expect(assigns(:question)).to eq(question2)
    end

    it "assigns @answers using question id" do
      get :ques_answers, question_id: question2.id
      answers = [answer2, answer3]
      expect(assigns(:answers)).to match_array(answers)
    end

    it "renders question answers page" do
      get :ques_answers, question_id: question2.id
      expect(response).to render_template('ques_answers')
      expect(response).to have_http_status(:success)
    end

    it "assigns @filter_my_ans when filter is applied" do
      get :ques_answers, question_id: question2.id, my_ans: true 
      expect(assigns(:filter_my_ans)).to eq(true)
    end

    it "assigns @answers with filters" do
      get :ques_answers, question_id: question2.id, my_ans: true 
      answers = [answer2]
      expect(assigns(:answers)).to match_array(answers)
    end
  end

  describe 'POST #edit' do
    before do
      post :edit, id: question1.id
    end

    it 'renders the edit template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('edit')
    end

    it 'assigns @question using id' do
      expect(assigns(:question)).to eq(question1)
    end
  end

  describe 'PATCH #update' do
    let!(:valid_question) { FactoryBot.attributes_for(:question, ques: "Modified Question") }
    let!(:invalid_question) {FactoryBot.attributes_for(:question, ques: "")}

    context 'when the user enters valid question' do
      it 'assigns the requested question to @question' do
        patch :update, id: question1.id, question: valid_question
        expect(assigns(:question)).to eq(question1)
      end

      it 'changes @question' do
        patch :update, id: question1.id, question: valid_question
        question1.reload
        expect(question1.ques).to eq('Modified Question')
      end

      it "sets the success flash" do
        patch :update, id: question1.id, question: valid_question
        expect(flash[:success]).to be_present
        expected_msg = "Question updated successfully."
        expect(flash[:success]).to eq(expected_msg)
      end

      it 'redirects to the questions page after updating question' do
        patch :update, id: question1.id, question: valid_question
        expect(response).to redirect_to(questions_path)
      end
    end

    context 'when the user enters invalid question' do
      it 'does not change the question' do
        patch :update, id: question1.id, question: invalid_question
        question1.reload
        expect(question1.ques).to_not eq("")
        expect(question1.ques).to eq("convenient location?")
      end

      it 're-renders the #edit template' do
        patch :update, id: question1.id, question: invalid_question
        expect(response).to render_template('edit')
      end
    end
  end

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

  describe 'GET #logged_in_user' do
    context 'when user is not logged in' do
      before do
        session[:user_id] = nil
        get :new
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
        get :new
        expect(response).to be_successful
      end
    end
  end
end