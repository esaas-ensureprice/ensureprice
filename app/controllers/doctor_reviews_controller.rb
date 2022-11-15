class DoctorReviewsController < ApplicationController
    before_action :logged_in_user

    def index
      if logged_in?
        redirect_to(root_url)
      end
    end
  
    def show
      if logged_in?
        redirect_to(root_url)
      end
    end

    def new
      doctor_id = session[:id]
      @doctor = Doctors.find(doctor_id)
      @doctor_review = DoctorReviews.new
    end

    def create
      doctor_id = session[:id]
      @doctor = Doctors.find(doctor_id)
      @doctor_review = DoctorReviews.new(doctor_review_params)

      # adding doctor info to doctor reviews table
      @doctor_review.doctor_id = doctor_id
      @doctor_review.doctor_name = @doctor.doctor_name

      # adding user info to doctor reviews table
      logged_in_user = User.find(session[:user_id])
      @doctor_review.user_email = logged_in_user.email
      @doctor_review.user_name = logged_in_user.name

      if @doctor_review.save
        flash[:success] = "Review for Dr. "+@doctor.doctor_name+" submitted successfully."
        redirect_to doctor_path(@doctor)
      else
        render 'new'
      end
    end

    def edit
      @doctor_review = DoctorReviews.find(params[:id])
    end

    def update
      @doctor_review = DoctorReviews.find(params[:id])
      if @doctor_review.update_attributes(doctor_review_params)
        flash[:success] = "Review updated"
        redirect_to current_user
      else 
        render 'edit'
      end
    end

    def reviews
      id = session[:id]
      @doctor = Doctors.find(id)
      @user_reviews = DoctorReviews.where(doctor_id: id)
    end

    def destroy
      @doctor_review = DoctorReviews.find(params[:id])
      @doctor_review.destroy
      flash[:success] = "Your Review was successfully deleted"
      redirect_to current_user
    end  

    private

      def doctor_review_params
        params.require(:doctor_review).permit(:user_review, :review_title)
      end
  
      # Confirms a logged-in user
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_path
        end
      end
end
