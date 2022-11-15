FactoryBot.define do
  factory :doctor_reviews do
    doctor_id { 1 }
    doctor_name { "test_doc" }
    user_email { "12345@gmail.com" }
    user_name { "xyzxyz" }
    review_title { "generic review title" }
    user_review { "best doc ever!" }
  end
end