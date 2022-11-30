class DoctorsController < ApplicationController
    before_action :logged_in_user

    # TO Delete
    def log_test(message)
      Rails.logger.info(message)
      puts message
    end
  
    def index
      @insurance_plans = InsurancePlan.uniq.pluck(:company_name)
      @designations = Doctor.uniq.pluck(:designation)
      @specialities = Doctor.uniq.pluck(:specialty) 
      @doctors = Doctor.all
      @plan_filter = (params[:insurance_plan] || !params[:insurance_plan].blank?) ? params[:insurance_plan] : (session[:insurance_plan] ? session[:insurance_plan] : nil)
      @designation_filter = (params[:designation] || !params[:designation].blank?) ? params[:designation] : (session[:designation] ? session[:designation] : nil)
      @specialty_filter = (params[:specialty] || !params[:specialty].blank?) ? params[:specialty] : (session[:specialty] ? session[:specialty] : nil)
     
      @doctors = @doctors.where(insurance_plan: @plan_filter) if @plan_filter && !@plan_filter.blank?
      @doctors = @doctors.where(designation: @designation_filter) if @designation_filter && !@designation_filter.blank?
      @doctors = @doctors.where(specialty: @specialty_filter) if @specialty_filter && !@specialty_filter.blank?

      if params[:query] && !params[:query].blank?
        query = "%"+params[:query]+"%"
        @doctors = @doctors.where("((((doctor_name LIKE ?) or specialty LIKE ?) or designation LIKE ?) or site_name LIKE ?) or insurance_plan LIKE ?", query, query, query, query, query)
      end
      
      # so that it does not take loading time for displaying all the 5500 doctors 
      @doctors = @doctors.limit(500)
      # sorting the doctors by average rating
      @sort_by = params[:sort] ? params[:sort] : (session[:sort] ? session[:sort] : nil)
      if @sort_by
        @doctors = @doctors.order(@sort_by+' DESC')
      end
      # storing the filter and sort values in session
      session[:sort] = @sort_by
      session[:insurance_plan] = @plan_filter
      session[:designation] = @designation_filter
      session[:specialty] = @specialty_filter
    end

    def show
      session[:id] = params[:id]
      @doctor = Doctor.find(params[:id])
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
