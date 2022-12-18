#Steps for asking, answering, searching, and upvoting questions
When /^I ask a question/ do
  click_link('Ask a Question', href: '/questions/new')
end

When /^I answer the question: "(.*)"$/ do |question|
  found_question = Question.find_by(ques: question)
  link = '/answers/new?question_id=' + found_question.id.to_s
  click_link('Answer', href: link)
end

When /^I view the answers for the question: "(.*)"$/ do |question|
  found_question = Question.find_by(ques: question)
  link = '/ques_answers/' + found_question.id.to_s
  click_link('View Answers', href: link)
end

Then /^I should see (.*) thumbs up buttons$/ do |expected|
  count = page.all("span.fa.fa-thumbs-up").size
  expect(count).to eq(expected.to_i)
end

When /^I upvote on the answer: "(.*)"$/ do |answer|
  found_answer = Answer.find_by(answer: answer)
  link = '/answers/' + found_answer.id.to_s + '/upvote'
  click_link('', href: link)
end