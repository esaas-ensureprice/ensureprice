class EnsurepricesController < ApplicationController
  before_action :logged_in_user

  def index
    if logged_in?
      redirect_to(root_url)
    end
  end

  def show
    @insurance_providers = InsurancePlan.uniq.pluck(:company_name)
  end

  def plans
     session[:id] = params[:id]
     @insurance_provider = session[:id]
     @insurance_plans = InsurancePlan.get_insurance_plans_by_provider @insurance_provider
  end

  def network_doctors
    session[:plan_id] = params[:id]
    @insurance_provider = session[:id]
    @doctors = Doctor.get_in_network_doctors @insurance_provider
    if params[:query] && !params[:query].blank?
      query = "%"+params[:query]+"%"
      @doctors = @doctors.where("(((doctor_name LIKE ?) or specialty LIKE ?) or designation LIKE ?) or site_name LIKE ?", query, query, query, query)
    end 
  end

  def visits
    session[:plan_id] = params[:id]
    @insurance_provider = session[:id]
    @visits = Visit.get_visits_by_insurance_plan
  end

  def price
    session[:visit_type] = params[:id]
    @insurance_provider = session[:id]
    @insurance_plan = session[:plan_id]
    @visit_type = session[:visit_type]
    @price, @deductible, @dollarSign = Price.get_price_by_insurance_plan @insurance_plan, @visit_type
    # For suggesting In-network Doctors sorted by average rating
    @doctors = Doctor.get_in_network_doctors @insurance_provider
    # Searching the doctors
    if params[:query] && !params[:query].blank?
      query = "%"+params[:query]+"%"
      @doctors = @doctors.where("(((doctor_name LIKE ?) or specialty LIKE ?) or designation LIKE ?) or site_name LIKE ?", query, query, query, query)
    end 
    @doctors = @doctors.limit(500).order('avg_rating DESC')
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
