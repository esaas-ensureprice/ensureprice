FactoryBot.define do
  factory :answer do
    question_id { 1 }
    answer { "MyString" }
    answered_by { 1 }
    upvotes { 1 }
  end
end
