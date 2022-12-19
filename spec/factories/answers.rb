FactoryBot.define do
  factory :answer do
    question_id { 1 }
    answer { "This is the Answer" }
    answered_by { 1 }
  end
end
