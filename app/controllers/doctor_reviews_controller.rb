class DoctorReviewsController < ApplicationController
    before_action :logged_in_user

    # TO Delete
    def log_test(message)
      Rails.logger.info(message)
      puts message
    end

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
      @doctor = Doctor.find(doctor_id)
      @doctor_review = DoctorReview.new
    end

    def create
      doctor_id = session[:id]
      @doctor = Doctor.find(doctor_id)
      @doctor_review = DoctorReview.new(doctor_review_params)

      # adding doctor info to doctor reviews table
      @doctor_review.doctor_id = doctor_id
      @doctor_review.doctor_name = @doctor.doctor_name

      # adding user info to doctor reviews table
      logged_in_user = User.find(session[:user_id])
      @doctor_review.user_email = logged_in_user.email
      @doctor_review.user_name = logged_in_user.name

      if @doctor_review.save
        # updating the avg_rating field for Doctor
        update_doctor_rating(@doctor.id)
        flash[:success] = "Review for Dr. "+@doctor.doctor_name+" submitted successfully."
        redirect_to doctor_path(@doctor)
      else
        render 'new'
      end
    end

    def edit
      @doctor_review = DoctorReview.find(params[:id])
    end

    def update
      @doctor_review = DoctorReview.find(params[:id])
      if @doctor_review.update_attributes(doctor_review_params)
        # updating the avg_rating field for Doctor
        update_doctor_rating(@doctor_review.doctor_id)
        flash[:success] = "Review for Dr. "+@doctor_review.doctor_name+" updated successfully."
        redirect_to current_user
      else 
        render 'edit'
      end
    end

    def reviews
      id = session[:id]
      @doctor = Doctor.find(id)
      @user_reviews = DoctorReview.where(doctor_id: id).order(created_at: :desc)
    end

    def destroy
      @doctor_review = DoctorReview.find(params[:id])
      doctor_id = @doctor_review.doctor_id
      @doctor_review.destroy
      # updating the avg_rating field for Doctor
      update_doctor_rating(doctor_id)
      flash[:success] = "Review for Dr. "+@doctor_review.doctor_name+" was deleted successfully."
      redirect_to current_user
    end  

    private

      def doctor_review_params
        params.require(:doctor_review).permit(:rating, :user_review, :review_title)
      end

      def update_doctor_rating(doctor_id)
        doctor = Doctor.find(doctor_id)
        rating, total_reviews = Doctor.compute_rating doctor
        doctor.update_attribute(:avg_rating, rating.nil? ? 0.0 : rating)
        doctor.update_attribute(:num_reviews, total_reviews.nil? ? 0 : total_reviews)
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
