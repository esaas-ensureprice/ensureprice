class AnswersController < ApplicationController
    before_action :logged_in_user

    def new
      question_id = params[:question_id]
      @question = Question.find(question_id)
      @answer = Answer.new
    end

    def create
      @answer = Answer.new(answer_params)
      @answer.question_id = params[:question_id]
      @answer.answered_by = session[:user_id]
      if @answer.save
        flash[:success] = "Answer submitted successfully."
        redirect_to questions_path
      else
        render 'new'
      end
    end

    def edit
      @answer = Answer.find(params[:id])
    end

    def update
      @answer = Answer.find(params[:id])
      if @answer.update_attributes(answer_params)
        flash[:success] = "Answer updated successfully."
        redirect_to ques_answers_path(question_id: @answer.question_id)
      else 
        render 'edit'
      end
    end

    def destroy
      @answer = Answer.find(params[:id])
      @answer.destroy
      flash[:success] = "Answer was deleted successfully."
      redirect_to ques_answers_path(question_id: @answer.question_id)
    end  

    private

     # to whitelist the parameters
      def answer_params
        params.require(:answer).permit(:answer)
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
