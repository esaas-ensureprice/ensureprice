Feature: Submitting a question and getting an answer 

  As a patient
  So that I can exchange information on medical insurance
  I want to be able to post questions, search questions, answer questions, and upvote answers

Background: the insurance plans and doctors tables have been seeded and user creates account
  Given the following insurance plans exist:
  | company_name            | insurance_plan_name                         | individual_annual_deductible | ov  | er  | uc  | spc | ho  |
  | UnitedHealthCare        | UNITEDHEALTHCARE: SAVINGS PLUS              | 1000                         | 10  | 100 | 10  | 10  | 10% |
  | UnitedHealthCare        | UNITEDHEALTHCARE: PREMIUM PLUS              | 2000                         | 20  | 200 | 20  | 20  | 20% |
  | Oscar                   | OSCAR LIFE INSURANCE COMPANY: BROAD PPO     | 3000                         | 30% | 30% | 30% | 30% | 30% |
  | Oscar                   | OSCAR LIFE INSURANCE COMPANY: COOL PPO      | 4000                         | 40% | 40% | 40% | 30% | 30% |
  | Aetna                   | AETNA LIFE INSURANCE COMPANY: BROAD PPO     | 5000                         | 50  | 50  | 5   | 5%  | 500 |
  | Aetna                   | AETNA LIFE INSURANCE COMPANY: SAFE PPO      | 6000                         | 60  | 60  | 60  | 60% | 600 |
  | Cigna                   | CIGNA LIFE INSURANCE COMPANY: BROAD PPO     | 7000                         | 70% | 70% | 70% | 70% | 70% |
  | Cigna                   | CIGNA LIFE INSURANCE COMPANY: SAFE PPO      | 8000                         | 80% | 80% | 80% | 80% | 800 |
  | Empire                  | EMPIRE LIFE INSURANCE COMPANY: SAVINGS PLUS | 9000                         | 90  | 90  | 90  | 90  | 900 |
  | Empire                  | EMPIRE HEALTH INSURANCE COMPANY OF NEW YORK | 9999                         | 99  | 99  | 99  | 99  | 999 |

  Given the following doctors exist:
  | last_name  | first_name | national_provider_identifier | medicaid_provider | site_name                                | room_or_suite | street_address    | town_city  | state | county | zip_code | phone_number | provider_type | gender | commercial_provider_indicator | plan_name                                             | insurance_plan            | specialty                  | designation        | doctor_name     | location                                       |
  | Mediavillo | Rene       | 1376622019                   | 99999999          | Liberty Avenue                           |               | 9202 Liberty Ave  | Ozone Park | NY    | Queens | 11417    | 8359729      | MD            | M      | No                            | AETNA LIFE INSURANCE COMPANY: SAFE PPO                | Aetna                     | Pediatric Gastroenterology | Specialist         | Rene Mediavillo | 9202 Liberty Ave, Ozone Park, Queens, NY 11417 |
  | Mehta      | Keyur      | 1235339326                   | 99999999          | 3Rd Avenue                               |               | 4487 3Rd Ave      | Bronx      | NY    | Bronx  | 457      | 9606430      | MD            | M      | No                            | AETNA LIFE INSURANCE COMPANY: SAFE PPO                | Aetna                     | Pediatric Gastroenterology | Specialist         | Keyur Mehta     | 4487 3Rd Ave, Bronx, Bronx, NY 457             |
  | Meritz     | Keith      | 1801956974                   | 99999999          | Maimonides Division Of Radiation Oncolog |               | 6300 8Th Ave      | Brooklyn   | NY    | Kings  | 112      | 7652722      | MD            | M      | No                            | UNITEDHEALTHCARE: SAVINGS PLUS                        | UnitedHealthCare          | Pediatric Gastroenterology | Specialist         | Keith Meritz    | 6300 8Th Ave, Brooklyn, Kings, NY 112          |
  | Milano     | Michael    | 1164452314                   | 99999999          | Elmwood Avenue                           |               | 601 Elmwood Ave   | Rochester  | NY    | Monroe | 14642    | 2752171      | MD            | M      | No                            | UNITEDHEALTHCARE: PREMIUM PLUS                        | UnitedHealthCare          | General Dentist            | Specialist         | Michael Milano  | 601 Elmwood Ave, Rochester, Monroe, NY 14642   |
  | Mishra     | Uma        | 1003803594                   | 99999999          | U.S. Hwy. 9W                             |               | 2565 Us Hwy 9W    | Cornwall   | NY    | Orange | 12518    | 5344700      | MD            | M      | No                            | OSCAR LIFE INSURANCE COMPANY: BROAD PPO               | Oscar                     | General Dentist            | Specialist         | Uma Mishra      | 2565 Us Hwy 9W, Cornwall, Orange, NY 12518     |
  | Mix        | Michael    | 1720379233                   | 99999999          | Champlin Avenue                          |               | 1656 Champlin Ave | Utica      | NY    | Oneida | 132      | 6245260      | MD            | F      | No                            | OSCAR LIFE INSURANCE COMPANY: COOL PPO                | Oscar                     | Cardiovascular Disease     | PCP and Specialist | Michael Mix     | 1656 Champlin Ave, Utica, Oneida, NY 132       |
  | Monster    | Cookie     | 1801956986                   | 99999999          | Maimonides Division Of Radiation Oncolog |               | 6300 8Th Ave      | Brooklyn   | NY    | Kings  | 112      | 7652722      | MD            | F      | No                            | EMPIRE LIFE INSURANCE COMPANY: SAVINGS PLUS           | Empire                    | Cardiovascular Disease     | PCP and Specialist | Cookie Monster  | 6300 8Th Ave, Brooklyn, Kings, NY 112          |
  | Pepsi      | Soda       | 0064452300                   | 99999999          | Elmwood Avenue                           |               | 601 Elmwood Ave   | Rochester  | NY    | Monroe | 14642    | 2752171      | MD            | F      | No                            | EMPIRE HEALTH INSURANCE COMPANY OF NEW YORK           | Empire                    | Radiologist Oncology       | PCP                | Soda Pepsi      | 601 Elmwood Ave, Rochester, Monroe, NY 14642   |
  | Guitar     | Hero       | 2303803598                   | 99999999          | U.S. Hwy. 9W                             |               | 2565 Us Hwy 9W    | Cornwall   | NY    | Orange | 12518    | 5344700      | MD            | F      | No                            | CIGNA LIFE INSURANCE COMPANY: BROAD PPO               | Cigna                     | Radiologist Oncology       | PCP                | Hero Guitar     | 2565 Us Hwy 9W, Cornwall, Orange, NY 12518     |
  | Cat        | Kitten     | 6720379200                   | 99999999          | Champlin Avenue                          |               | 1656 Champlin Ave | Utica      | NY    | Oneida | 132      | 6245260      | MD            | F      | No                            | CIGNA LIFE INSURANCE COMPANY: SAFE PPO                | Cigna                     | Radiologist Oncology       | PCP                | Kitten Cat      | 1656 Champlin Ave, Utica, Oneida, NY 132       |                    
  
  Then 10 seed insurance plans should exist
  Then 10 seed doctors should exist

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

