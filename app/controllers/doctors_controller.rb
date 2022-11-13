class DoctorsController < ApplicationController
    before_action :logged_in_user
  
    # TO Delete
    def log_test(message)
      Rails.logger.info(message)
      puts message
    end

    def index
      @doctors = Doctors.all
      @doctors = @doctors.where(insurance_plan: params[:insurance]) if params[:insurance]
      @doctors = @doctors.where(designation: params[:designation]) if params[:designation]
    end
  
    def show
      session[:id] = params[:id]
      @doctor = Doctors.find(params[:id])
    end

    private

      def doctor_params
        params.require(:doctor).permit(:doctor_name, :gender, :location, :insurance_plan, :specialty, :designation, :national_provider_identifier, :medicaid_provider, :phone_number, :provider_type, :commercial_provider_indicator) 
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
