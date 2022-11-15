require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:valid_attributes) {
    {
      name: "name",
      email: "email@gmail.com",
      password: "Password Digest",
      password_confirmation: "Password Digest",
    }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      email: "email@gmail.com",
      password: "Password Digest",
      password_confirmation: "Password Digest",
    }
  }

  describe 'GET #show' do
    let!(:user) { User.create! valid_attributes }
    let!(:doctor_review1) { FactoryBot.create(:doctor_reviews, user_email: user.email, user_name: user.name) }
    let!(:doctor_review2) { FactoryBot.create(:doctor_reviews, doctor_name: 'Jessica Soni', user_email: user.email, user_name: user.name) }

    before do
      get :show, id: user.id
    end

    it 'should assign the requested user to @user' do
      expect(assigns(:user)).to eq user
    end

    it 'should assign the @user_reviews to current user reviews' do
      expected_result = [doctor_review1, doctor_review2]
      expect(assigns(:user_reviews)).to eq(expected_result)
    end

    it 'should render the :show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    let!(:user) { User.create! valid_attributes }

    before do
      get :new
    end

    it 'assigns a new User to @user' do
      expect(assigns(:user)).to be_a_new User
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let!(:user1) { FactoryBot.attributes_for(:user, valid_attributes) }
    let!(:invalid_user1) { FactoryBot.attributes_for(:user, invalid_attributes) }

    context 'when the user signups with valid attributes' do
      it "should save a new user in the database" do
        expect{
          post :create, user: user1
        }.to change(User, :count).by(1)
      end

      it "should log the user in" do
        post :create, user: user1
        expect(session[:user_id]).to eq(assigns(:user).id)
      end

      it "should set the success flash" do
        post :create, user: user1
        expect(flash[:success]).to be_present
        expect(flash[:success]).to eq("Welcome to the EnsurePrice App!")
      end

      it 'should redirect to the new user' do
        post :create, user: user1
        expect(response).to redirect_to User.last
      end
    end

    context 'when the user signups with invalid attributes' do
      it "should not save the new user in the database" do
        expect{
          post :create, user: invalid_user1
        }.to_not change(User, :count)
      end

      it 'should re-render the :new template' do
        post :create, user: invalid_user1
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    let!(:user1) { User.create! valid_attributes }

    context 'when the user is logged in' do
      before do
        # logging the user in
        session[:user_id] = user1.id
        get :edit, id: user1.id
      end

      it 'should assign the requested user to @user using id' do
        get :edit, id: user1.id
        expect(assigns(:user)).to eq(User.find(user1.id))
      end

      it 'should render the :edit template' do
        get :edit, id: user1.id
        expect(response).to render_template :edit
      end
    end

    context 'when the user is not logged in' do
      it 'should redirect the user to login page' do
        get :edit, id: user1.id
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:user1) { User.create! valid_attributes }
    let!(:invalid_user1) { FactoryBot.attributes_for(:user, invalid_attributes) }

    context 'when the user enters valid attributes' do
      before do
        session[:user_id] = user1.id
      end

      it 'should assign the requested user to @user' do
        patch :update, id: user1.id, user: valid_attributes
        expect(assigns(:user)).to eq user1
      end

      it 'should change @user attributes' do
        patch :update, id: user1.id, user: valid_attributes.merge(name: 'New Name')
        user1.reload
        expect(user1.name).to eq('New Name')
      end

      it "should set the success flash" do
        patch :update, id: user1.id, user: valid_attributes
        expect(flash[:success]).to be_present
        expect(flash[:success]).to eq("Profile updated")
      end

      it 'should redirect to the updated user' do
        patch :update, id: user1.id, user: valid_attributes
        expect(response).to redirect_to(user_path)
      end
    end

    context 'when the user enters invalid attributes' do
      before do
        session[:user_id] = user1.id
      end

      it 'should not change @user attributes' do
        patch :update, id: user1.id, user: invalid_attributes.merge(email: 'newmail@gmail.com')
        user1.reload
        expect(user1.email).to_not eq('newmail@gmail.com')
      end

      it 'should re-render the #edit template' do
        patch :update, id: user1.id, user: invalid_attributes
        expect(response).to render_template :edit
      end
    end
  end
end