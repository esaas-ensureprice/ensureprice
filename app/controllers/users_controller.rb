class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]

  def index
    if logged_in?
      redirect_to(root_url)
    end
  end

  def show
    @user = User.find(params[:id])
    email = @user.email
    @user_reviews = DoctorReview.where(user_email: email)
    if params[:query] && !params[:query].blank?
      query = "%"+params[:query]+"%"
      @user_reviews = @user_reviews.where("(doctor_name LIKE ?) or review_title LIKE ?", query, query)
    end 
    @user_reviews = @user_reviews.order(updated_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the EnsurePrice App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
    #debugger
  end

  private

    # to whitelist the parameters
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless logged_in? && current_user?(@user)
    end
end
