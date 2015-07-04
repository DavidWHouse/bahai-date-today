Given(/^I am on the (.+) page$/) do |page_name|
  case page_name
  when 'landing'
    visit root_path
  else
    visit name_to_path(page_name)
  end
end

When(/^I click on the (.+) link$/) do |link|
  click_link link
end

When(/^I fill in the contact form$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see (.+)$/) do |text|
  expect(page).to have_content(replace_tokens_in(text))
end

Then(/^I should be on the "(.*?)" page$/) do |page_name|
  expect(current_path).to eq(name_to_path(page_name))
end

Then(/^the navigation bar should be visible$/) do
  expect(page).to have_css('.navbar')
end

Then(/^the "(.*?)" link should be highlighted$/) do |link|
  expect(page).to have_css("##{link}.current")
end

Then(/^the Administrator should receive an email$/) do
  pending # express the regexp above with the code you wish you had
end

def replace_tokens_in(text)
  return Date.today if text == "today's date in the gregorian calendar"
  text
end

def name_to_path(page_name)
  "#{page_name}_path".to_sym
end
