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
     @insurance_plan = params[:id]
     @doctors = Doctors.get_doctors_by_plan @insurance_plan
     log_test @doctors
  end

  # def create
  #   @movie = Movie.create!(movie_params)
  #   flash[:notice] = "#{@movie.title} was successfully created."
  #   redirect_to movies_path
  # end

  # def edit
  #   @movie = Movie.find params[:id]
  # end

  # def update
  #   @movie = Movie.find params[:id]
  #   @movie.update_attributes!(movie_params)
  #   flash[:notice] = "#{@movie.title} was successfully updated."
  #   redirect_to movie_path(@movie)
  # end

  # def destroy
  #   @movie = Movie.find(params[:id])
  #   @movie.destroy
  #   flash[:notice] = "Movie '#{@movie.title}' deleted."
  #   redirect_to movies_path
  # end

  # private
  # # Making "internal" methods private is not required, but is a common practice.
  # # This helps make clear which methods respond to requests, and which ones do not.
  # def movie_params
  #   params.require(:movie).permit(:title, :rating, :description, :release_date)
  # end
end
