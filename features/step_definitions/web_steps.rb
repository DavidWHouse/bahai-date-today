When(/^I visit the landing page$/) do
  visit root_path
end

Then(/^I see (.+)$/) do |text|
  content = replace_tokens_in(text)
  expect(page).to have_content(content)
end
