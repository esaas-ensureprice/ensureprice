FactoryBot.define do
    factory :doctor_reviews do
      doctor_name {'Jaime Madden'}
      user_email {'user@gmail.com'}
      user_name {'username'}
      review_title {'Great Doctor'}
      user_review {'Doctor listened very intently to concerns and ran extra tests as precautions to ease my worries.'}
    end
end