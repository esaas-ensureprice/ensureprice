Feature: Submitting a question and getting an answer 

  As a patient
  So that I can exchange information on medical insurance
  I want to be able to post questions, search questions, answer questions, and upvote answers

Background: the insurance plans and doctors tables have been seeded and user creates account
  Given I am on the Ensureprice homepage
  When I follow "Login"
  When I follow "Sign up now!"
  Then I should see "Sign Up"
  When I fill in the following information: User1, user@gmail.com, 12345678, 12345678
  When I press "Create my account"
  When I follow "FAQ"
  Then I should see the following: Frequently Asked Questions
  When I ask a question
  When I fill in "question_ques" with "This is a question"
  When I press "Submit"
  Then I should see the following: Question submitted successfully, This is a question
  Then I should see the following buttons: View Answers, Edit, Delete
  Then I should not see "Answer" button
  When I follow "Log out"
  When I follow "Login"
  When I follow "Sign up now!"
  Then I should see "Sign Up"
  When I fill in the following information: User2, user2@gmail.com, 12345678, 12345678
  When I press "Create my account"
  When I follow "FAQ"
  Then I should see "This is a question"

Scenario: Add question without entering anything in the text field 
  When I ask a question
  When I fill in "question_ques" with ""
  When I press "Submit"
  Then I should see the following: The form contains 1 error, Ques can't be blank

Scenario: Answer a question and viewing the answers, resubmitting an answer to a question is prohibited
  When I answer the question: "This is a question"
  Then I should see the following: Give an Answer, This is a question
  When I fill in "answer_answer" with "This is an answer"
  When I press "Submit Answer"
  Then I should see the following: Answer submitted successfully.
  When I view the answers for the question: "This is a question"
  Then I should see the following: This is an answer
  Then I should see the following buttons: Edit, Delete
  Then I should see 0 thumbs up buttons

Scenario: Resubmitting an answer to a question is prohibited
  When I answer the question: "This is a question"
  Then I should see the following: Give an Answer, This is a question
  When I fill in "answer_answer" with "This is an answer"
  When I press "Submit Answer"
  Then I should see the following: Answer submitted successfully.
  When I answer the question: "This is a question"
  Then I should see the following: Give an Answer, This is a question
  When I fill in "answer_answer" with "This is another answer"
  When I press "Submit Answer"
  Then I should see the following: Give an Answer, Submit Failed! You might have already submitted an answer to this question.

Scenario: Upvote a question and re-upvoting is not allowed
  When I answer the question: "This is a question"
  Then I should see the following: Give an Answer, This is a question
  When I fill in "answer_answer" with "This is an answer"
  When I press "Submit Answer"
  Then I should see the following: Answer submitted successfully.
  When I view the answers for the question: "This is a question"
  Then I should see the following: This is an answer
  Then I should see the following buttons: Edit, Delete
  Then I should see 0 thumbs up buttons
  When I follow "Log out"
  When I follow "Login"
  When I fill in the login information: user@gmail.com, 12345678
  Then I press "Log in"
  When I follow "FAQ"
  When I view the answers for the question: "This is a question"
  Then I should see the following: This is an answer
  When I upvote on the answer: "This is an answer"
  Then I should see the following: Thank you for upvoting!
  When I upvote on the answer: "This is an answer"
  Then I should see the following: You have already upvoted this!

Scenario: Filtering for your questions only
  When I ask a question
  When I fill in "question_ques" with "My question"
  When I press "Submit"
  Then I should see the following: Question submitted successfully, My question
  When I ask a question
  When I fill in "question_ques" with "My question2"
  When I press "Submit"
  Then I should see the following: Question submitted successfully, My question, My question2
  When I check "my_ques"
  When I press "Refresh"
  Then I should see "My question2" before "My question"
  Then I should not see "This is a question"

Scenario: Edit question
  When I ask a question
  When I fill in "question_ques" with "My question"
  When I press "Submit"
  Then I should see the following: Question submitted successfully, My question
  When I edit the question: "My question"
  When I fill in "question_ques" with "Your question"
  When I press "Update My Question"
  Then I should see the following: Question updated successfully, Your question

Scenario: Edit question without entering anything in the text field
  When I ask a question
  When I fill in "question_ques" with "My question"
  When I press "Submit"
  Then I should see the following: Question submitted successfully, My question
  When I edit the question: "My question"
  When I fill in "question_ques" with ""
  When I press "Update My Question"
  Then I should see the following: The form contains 1 error, Ques can't be blank

Scenario: Delete question
  When I ask a question
  When I fill in "question_ques" with "My question"
  When I press "Submit"
  Then I should see the following: Question submitted successfully, My question
  When I delete the question: "My question"
  Then I should see "Question was deleted successfully"
  Then I should not see "My question"

Scenario: Edit answer
  When I answer the question: "This is a question"
  Then I should see the following: Give an Answer, This is a question
  When I fill in "answer_answer" with "This is an answer"
  When I press "Submit Answer"
  Then I should see the following: Answer submitted successfully
  When I view the answers for the question: "This is a question"
  When I edit the answer: "This is an answer"
  When I fill in "answer_answer" with "Edited answer"
  When I press "Update My Answer"
  Then I should see the following: Answer updated successfully, Edited answer

Scenario: Edit answer without entering anything in the text field
  When I answer the question: "This is a question"
  Then I should see the following: Give an Answer, This is a question
  When I fill in "answer_answer" with "This is an answer"
  When I press "Submit Answer"
  Then I should see the following: Answer submitted successfully
  When I view the answers for the question: "This is a question"
  When I edit the answer: "This is an answer"
  When I fill in "answer_answer" with ""
  When I press "Update My Answer"
  Then I should see the following: The form contains 1 error, Answer can't be blank

Scenario: Delete answer
  When I answer the question: "This is a question"
  Then I should see the following: Give an Answer, This is a question
  When I fill in "answer_answer" with "This is an answer"
  When I press "Submit Answer"
  Then I should see the following: Answer submitted successfully
  When I view the answers for the question: "This is a question"
  When I delete the answer: "This is an answer"
  Then I should see "Answer was deleted successfully."
  Then I should not see "This is an answer"

Scenario: Search for questions
  When I ask a question
  When I fill in "question_ques" with "My question"
  When I press "Submit"
  Then I should see the following: Question submitted successfully, My question
  When I fill in "query" with "my"
  When I press "Search"
  Then I should see "My question"
  Then I should not see "This is a question"

