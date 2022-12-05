class QuestionsController < ApplicationController
    before_action :logged_in_user

    def index
      @questions = Question.all
      @filter_my_ques = params[:my_ques]
      if @filter_my_ques
        @questions = @questions.where(asked_by: session[:user_id])
      end
      # Search functionality based on question
      if params[:query] && !params[:query].blank?
        query = "%"+params[:query]+"%"
        @questions = @questions.where("ques LIKE ?", query)
      end
      @questions = @questions.order(updated_at: :desc)
    end

    def new
      @question = Question.new
    end

    def create
      @question = Question.new(question_params)
      @question.asked_by = session[:user_id]
      if @question.save
        flash[:success] = "Question submitted successfully."
        redirect_to questions_path
      else
        render 'new'
      end
    end
    
    def ques_answers
      @question = Question.find(params[:question_id])
      @answers = Answer.where(question_id: @question.id)
      @filter_my_ans = params[:my_ans]
      if @filter_my_ans
        @answers = @answers.where(answered_by: session[:user_id])
      end
      @answers = @answers.order(updated_at: :desc)
    end

    def edit
      @question = Question.find(params[:id])
    end

    def update
      @question = Question.find(params[:id])
      if @question.update_attributes(question_params)
        flash[:success] = "Question updated successfully."
        redirect_to questions_path
      else 
        render 'edit'
      end
    end

    def destroy
      @question = Question.find(params[:id])
      @question.destroy
      flash[:success] = "Question was deleted successfully."
      redirect_to questions_path
    end  

    private

     # to whitelist the parameters
      def question_params
        params.require(:question).permit(:ques)
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
