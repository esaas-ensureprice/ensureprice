FactoryBot.define do
  factory :question do
    ques { "MyString" }
    asked_by { 1 }
    upvotes { 1 }
  end
end
