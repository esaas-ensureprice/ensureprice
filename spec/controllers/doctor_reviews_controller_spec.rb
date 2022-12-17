require 'rails_helper'

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

    let!(:insurance_plan1) {FactoryBot.create(:insurance_plan, company_name: 'Company1', insurance_plan_name: 'PLAN1', individual_annual_deductible: '5000')}
    let!(:review1) {FactoryBot.create(:doctor_review, doctor_id: 1, doctor_name: 'Dr. Yukti')}
    let!(:doctor1) {FactoryBot.create(:doctor, doctor_name: 'Dr. Yukti', insurance_plan: "Company1")}

    before do
        # logging the user in
        session[:user_id] = user1.id
    end

    describe 'GET #index' do
        it 'redirects to the root path' do
            get :index
            expect(response).to redirect_to(root_path)
        end
    end

    describe 'GET #show' do
        it 'redirects to the root path' do
            get :show, id: review1.id
            expect(response).to redirect_to(root_path)
        end
    end

    describe 'GET #new' do

        before do
            @request.session[:id] = doctor1.id
            get :new, id: review1.id
        end

        it "assigns @doctor with doctor having session id" do
            expect(assigns(:doctor)).to eq doctor1
        end
        
        it 'creates empty new doctor review' do
            expect(assigns(:doctor_review)).to have_attributes(:doctor_id => nil)
        end

        it 'renders the new template' do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('new')
        end
    end

    describe 'POST #create' do
        let!(:doctor) { FactoryBot.create(:doctor) }
        let!(:doctor_review1) { FactoryBot.attributes_for(:doctor_review) }

        before do
            @request.session[:id] = doctor.id
        end

        context 'with valid doctor review attributes' do
            it 'saves a new doctor review in the database' do
                expect{
                    post :create, doctor_review: doctor_review1
                }.to change(DoctorReview, :count).by(1)
            end
        
            it 'sets the success flash' do
                post :create, doctor_review: doctor_review1
                expect(flash[:success]).to be_present
                expected_msg = "Review for Dr. "+doctor.doctor_name+" submitted successfully."
                expect(flash[:success]).to eq(expected_msg)
            end

            it 'sets the correct attributes to @doctor_review' do
                post :create, doctor_review: doctor_review1
                doctor_review = assigns(:doctor_review)
                expect(doctor_review.doctor_name).to eq(doctor.doctor_name)
                expect(doctor_review.user_email).to eq(user1.email)
                expect(doctor_review.user_name).to eq(user1.name)
                expect(doctor_review.review_title).to eq(doctor_review1[:review_title])
                expect(doctor_review.user_review).to eq(doctor_review1[:user_review])
            end

            it "redirects to the doctor's show page" do
                post :create, doctor_review: doctor_review1
                expect(response).to redirect_to(assigns[:doctor])
            end
        end

        context 'with invalid doctor review attributes' do
            it 're-renders the #new template' do
                post :create, doctor_review: doctor_review1.merge(user_review: nil)
                expect(response).to render_template :new
            end
        end
    end

    describe 'POST #edit' do
        before do 
            post :edit, id: review1.doctor_id
        end

        it 'renders the edit template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template('edit')
        end

        it 'assigns the requested doctor_review to @doctor_review using id' do
            doctor_review = assigns(:doctor_review)
            expect(doctor_review.id).to eq(review1.id)
        end
      
        it 'renders the :edit template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template :edit
        end
    end

    describe 'PATCH #update' do
        let(:valid_review) {
            {
                review_title: 'Great Doctor',
                user_review: 'Doctor is excellent. He is a clear communicator, takes the time to explain what different test results mean.'
            }
        }
    
        let(:invalid_review) {
            {
                review_title: 'Great Doctor',
                user_review: nil
            }
        }
    
        context 'when the user enters valid attributes' do
            it 'assigns the requested doctor review to @doctor_review' do
                patch :update, id: review1.id, doctor_review: valid_review
                expect(assigns(:doctor_review)).to eq review1
            end

            it 'changes @user attributes' do
                patch :update, id: review1.id, doctor_review: valid_review.merge(review_title: 'New Title')
                review1.reload
                expect(review1.review_title).to eq('New Title')
            end

            it "sets the success flash" do
                patch :update, id: review1.id, doctor_review: valid_review
                expect(flash[:success]).to be_present
                expected_msg = "Review for Dr. "+review1.doctor_name+" updated successfully."
                expect(flash[:success]).to eq(expected_msg)
            end
        
            it 'redirects to the user profile after updating review' do
                patch :update, id: review1.id, doctor_review: valid_review
                expect(response).to redirect_to(user_path)
            end
        end
    
        context 'when the user enters invalid attributes' do
            it 'does not change @doctor_review attributes' do
                patch :update, id: review1.id, doctor_review: invalid_review.merge(user_review: 'New Review')
                user1.reload
                expect(user1.email).to_not eq('New Review')
            end
        
            it 're-renders the #edit template' do
                patch :update, id: review1.id, doctor_review: invalid_review
                expect(review1.user_review).to render_template :edit
            end
        end
    end

    describe 'GET #reviews' do
        let!(:doctor2) { FactoryBot.create(:doctor) }
        let!(:review2) { FactoryBot.create(:doctor_review, doctor_id: doctor1.id, doctor_name: 'Test doctor 2') }
        let!(:review3) { FactoryBot.create(:doctor_review, doctor_id: doctor2.id, doctor_name: 'Test doctor 3') }
        let!(:review4) { FactoryBot.create(:doctor_review, doctor_id: doctor1.id, doctor_name: 'Test doctor 4') }

        before do
            @request.session[:id] = doctor1.id
            get :reviews
        end

        it 'assigns doctor by id' do
            expect(assigns(:doctor)).to eq doctor1
        end

        it 'assigns the requested reviews to @user_reviews in descending order' do
            expected_reviews = [review1, review2, review4]
            expected_reviews = expected_reviews.sort{|r1,r2| r2[:created_at] <=> r1[:created_at]}
            expect(assigns(:user_reviews)).to eq expected_reviews
        end

        it 'renders the reviews template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template('reviews')
        end
    end
   
    describe "DELETE #destroy" do
        it "destroys the requested doctor_review" do
            expect {
                delete :destroy, id: review1.id
            }.to change(DoctorReview, :count).by(-1)
        end
        
        it "sets the success flash" do
            delete :destroy, id: review1.id
            expect(flash[:success]).to be_present
            expected_msg = "Review for Dr. "+review1.doctor_name+" was deleted successfully."
            expect(flash[:success]).to eq(expected_msg)
        end

        it "re-renders the user profile " do
            delete :destroy, id: review1.id
            expect(response).to redirect_to(user_path)
        end
    end

    describe 'GET #logged_in_user' do
        context 'when user is not logged in' do
            before do
                session[:user_id] = nil
                @request.session[:id] = doctor1.id
                get :new, id: review1.id
            end

            it 'sets the danger flash' do
                expect(flash[:danger]).to be_present
                expect(flash[:danger]).to eq('Please log in.')
            end

            it 'redirects to login_path' do
                expect(response).to redirect_to(login_path)
            end
        end

        context "when user is logged in" do
            it "redirects to login_path" do
                @request.session[:id] = doctor1.id
                get :new, id: review1.id
                expect(response).to be_success
            end
        end
    end
end