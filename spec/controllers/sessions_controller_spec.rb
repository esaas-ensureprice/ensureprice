require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  let(:valid_attributes) {
    {
        name: "name",
        email: "email@gmail.com",
        password: "Password Digest",
        password_confirmation: "Password Digest",
    }
  }

  let(:invalid_login) { 
      { 
          name: "name", 
          email: "email@gmail.com",
          password: "wrongpassword",
      } 
  }
  describe "GET #new" do
      it "should return http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
  end

  describe "POST #create" do
    let!(:user1) { User.create! valid_attributes }

    context "with valid email and password" do
      it "should log in the user" do
        post :create, session: valid_attributes
        expect(subject.current_user).to eq(user1)
      end

      it "should redirect to the root path" do
        post :create, session: valid_attributes
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid email or password" do

      it "should set the danger flash" do
        post :create, session: invalid_login
        expect(flash[:danger]).to be_present
        expect(flash[:danger]).to eq('Invalid email/password combination')
      end

      it 'should re-render the :new template' do
        post :create, session: invalid_login
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE #destroy" do
    it "should log out the user" do
      delete :destroy
      expect(subject.current_user).to eq(nil)
    end

    it "should redirect to the root path" do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end