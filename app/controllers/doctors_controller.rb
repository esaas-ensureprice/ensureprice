class DoctorsController < ApplicationController
    before_action :logged_in_user

    # TO Delete
    def log_test(message)
      Rails.logger.info(message)
      puts message
    end
  
    def index
      @insurance_plans = InsurancePlans.uniq.pluck(:company_name)
      @designations = Doctors.uniq.pluck(:designation)
      @specialities = Doctors.uniq.pluck(:specialty)
      @doctors = Doctors.all
      @doctors = @doctors.where(insurance_plan: params[:insurance_plan]) if params[:insurance_plan] && !params[:insurance_plan].blank?
      @doctors = @doctors.where(designation: params[:designation]) if params[:designation] && !params[:designation].blank?
      @doctors = @doctors.where(specialty: params[:specialty]) if params[:specialty] && !params[:specialty].blank?
      if params[:query] && !params[:query].blank?
        query = "%"+params[:query]+"%"
        @doctors = @doctors.where("((((doctor_name LIKE ?) or specialty LIKE ?) or designation LIKE ?) or site_name LIKE ?) or insurance_plan LIKE ?", query, query, query, query, query)
      end
      # so that it does not take loading time for displaying all the 5500 doctors 
      @doctors = @doctors.limit(500)
      @ratings = Hash.new
      for doctor in @doctors do
        @ratings[doctor.id] = Doctors.compute_rating(doctor).round(2)
      end
    end

    def show
      session[:id] = params[:id]
      @doctor = Doctors.find(params[:id])
      @doctor_rating = (Doctors.compute_rating @doctor).round(2)
    end
    
    private

      # Confirms a logged-in user
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_path
        end
      end
end
