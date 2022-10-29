class EnsurepricesController < ApplicationController

  #To delete
  def log_test(message)
    Rails.logger.info(message)
    puts message
  end

  def show
     @insurance_providers = InsurancePlans.uniq.pluck(:company_name)
  end

  def plans
     @insurance_provider = params[:id]
     @insurance_plans = InsurancePlans.get_insurance_plans_by_provider @insurance_provider
  end

  def doctors
     @insurance_provider = params[:id]
     @doctors = Doctors.get_doctors_by_provider @insurance_provider
     log_test @doctors
  end
end
