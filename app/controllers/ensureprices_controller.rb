class EnsurepricesController < ApplicationController
  #before_action :logged_in_user

  # TO Delete
  #def log_test(message)
  #  Rails.logger.info(message)
  #  puts message
  #end

  def show
     @insurance_providers = InsurancePlans.uniq.pluck(:company_name)
     #log_test(@insurance_providers)
  end

  def plans
     session[:id] = params[:id]
     @insurance_provider = session[:id]
     @insurance_plans = InsurancePlans.get_insurance_plans_by_provider @insurance_provider
  end

  def network_doctors
     session[:plan_id] = params[:id]
     @insurance_provider = session[:id]
     @doctors = Doctors.get_in_network_doctors @insurance_provider
  end

  def visits
    session[:doctor_name] = params[:id]
    @visits = Visits.get_visits_by_insurance_plan
  end

  def price
    session[:visit_type] = params[:id]
    @insurance_plan = session[:plan_id]
    @doctor_name = session[:doctor_name]
    @visit_type = session[:visit_type]
    @price, @deductible, @dollarSign = Price.get_price_by_insurance_plan @insurance_plan, @visit_type
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
