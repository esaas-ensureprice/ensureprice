class DoctorsController < ApplicationController
  before_action :logged_in_user

    def index
      @insurance_plans = InsurancePlans.uniq.pluck(:company_name)
      @designations = Doctors.uniq.pluck(:designation)
      @specialities = Doctors.uniq.pluck(:specialty)
      @doctors = Doctors.all
      @doctors = @doctors.where(insurance_plan: params[:insurance_plan]) if params[:insurance_plan] && !params[:insurance_plan].blank?
      @doctors = @doctors.where(designation: params[:designation]) if params[:designation] && !params[:designation].blank?
      @doctors = @doctors.where(specialty: params[:specialty]) if params[:specialty] && !params[:specialty].blank?
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
