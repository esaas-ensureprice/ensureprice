Feature: Filtering answers given by user to a question

  As a patient
  So that I can exchange information on medical insurance
  I want to be able to view, edit and delete my own answers to questions

Background: the insurance plans and doctors tables have been seeded and user creates account
  Given I am on the Ensureprice homepage
  When I follow "Login"
  When I follow "Sign up now!"
  When I fill in the following information: User1, user1@gmail.com, user12345, user12345
  When I press "Create my account"
  When I follow "FAQ"
  When I ask a question
  When I fill in "question_ques" with "This is a question by user1"
  When I press "Submit"
  Then I should see the following: Question submitted successfully, This is a question by user1
  When I follow "Log out"
  When I follow "Login"
  When I follow "Sign up now!"
  When I fill in the following information: User2, user2@gmail.com, 12345678, 12345678
  When I press "Create my account"
  When I follow "FAQ"
  When I answer the question: "This is a question by user1"
  Then I should see the following: Give an Answer, This is a question by user1
  When I fill in "answer_answer" with "This is an answer by user2"
  When I press "Submit Answer"
  Then I should see the following: Answer submitted successfully.

Scenario: Filtering for your answers only
  When I follow "Log out"
  When I follow "Login"
  When I follow "Sign up now!"
  When I fill in the following information: User3, user3@gmail.com, 12345678, 12345678
  When I press "Create my account"
  When I follow "FAQ"
  When I answer the question: "This is a question by user1"
  When I fill in "answer_answer" with "This is an answer by user3"
  When I press "Submit Answer"
  Then I should see the following: Answer submitted successfully.
  When I view the answers for the question: "This is a question by user1"
  When I check "my_ans"
  When I press "Refresh"
  Then I should see "This is an answer by user3"
  Then I should not see "This is an answer by user2"