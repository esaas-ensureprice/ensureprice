class DoctorReviewsController < ApplicationController
    before_action :logged_in_user
  
    # TO Delete
    def log_test(message)
      Rails.logger.info(message)
      puts message
    end
  
    def show
      @all_doctors = Doctors.all
    end

    def info
      session[:id] = params[:id]
      @current_doctor_id = session[:id]
      log_test @current_doctor_id
      @doctor_info = DoctorReviews.get_doctor_info @current_doctor_id
      log_test @doctor_info
    end
  
    private
  
      # Confirms a logged-in user.
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_path
        end
      end
end
  