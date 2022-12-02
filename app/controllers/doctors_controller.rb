class DoctorsController < ApplicationController
    before_action :logged_in_user

    def index
      @insurance_plans = InsurancePlan.uniq.pluck(:company_name)
      @designations = Doctor.uniq.pluck(:designation)
      @specialities = Doctor.uniq.pluck(:specialty) 
      @doctors = Doctor.all

      # Filter functionality based on insurance plan, designation and specialty
      @plan_filter = (params[:insurance_plan] || !params[:insurance_plan].blank?) ? params[:insurance_plan] : (session[:insurance_plan] ? session[:insurance_plan] : nil)
      @designation_filter = (params[:designation] || !params[:designation].blank?) ? params[:designation] : (session[:designation] ? session[:designation] : nil)
      @specialty_filter = (params[:specialty] || !params[:specialty].blank?) ? params[:specialty] : (session[:specialty] ? session[:specialty] : nil)
     
      @doctors = @doctors.where(insurance_plan: @plan_filter) if @plan_filter && !@plan_filter.blank?
      @doctors = @doctors.where(designation: @designation_filter) if @designation_filter && !@designation_filter.blank?
      @doctors = @doctors.where(specialty: @specialty_filter) if @specialty_filter && !@specialty_filter.blank?

      # Search functionality based on doctor name and site name
      if params[:query] && !params[:query].blank?
        query = "%"+params[:query]+"%"
        @doctors = @doctors.where("(doctor_name LIKE ?) or site_name LIKE ?", query, query)
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
