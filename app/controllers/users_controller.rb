class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

   # TO Delete
  def log_test(message)
    Rails.logger.info(message)
    puts message
  end

  def show
    @user = User.find(params[:id])
    email = @user.email
    log_test(email)
    @user_reviews = DoctorReviews.where(user_email: email)
    # doc_id = @user_reviews.pluck(:).doctor_id
    # @doctor = Doctor.find(doc_id)
    log_test(@user_reviews)
    #debugger
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
  end

  def edit_review
    @user = User.find(params[:id])
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
      redirect_to(root_url) unless current_user?(@user)
    end
end
