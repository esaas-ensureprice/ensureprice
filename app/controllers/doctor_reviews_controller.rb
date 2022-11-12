class DoctorReviewsController < ApplicationController
    before_action :logged_in_user
  
    # TO Delete
    def log_test(message)
      Rails.logger.info(message)
      puts message
    end

    def index
      @doctors = Doctors.all
    end
  
    def show
      session[:id] = params[:id]
      @doctor = Doctors.find(params[:id])
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
        redirect_to @doctor_review
      else
        render 'new'
      end
    end

    private

      def doctor_review_params
        params.require(:doctor_review).permit(:user_review, :review_title)
      end
  
      # Confirms a logged-in user.
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_path
        end
      end
end
  