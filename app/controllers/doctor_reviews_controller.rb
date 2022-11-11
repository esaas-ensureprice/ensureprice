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
  