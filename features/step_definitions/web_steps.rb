Given(/^I am on the (.+) page$/) do |page_name|
  case page_name
  when 'landing'
    visit root_path
  else
    visit name_to_path(page_name)
  end
end

When(/^I click on the "(.+)" link$/) do |page_title|
  click_link page_title
end

When(/^I fill in the contact form$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see today's date in the gregorian calendar$/) do
  expect(page).to have_content(Date.today)
end

Then(/^I should see "(.+)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^the page title should include "(.*?)"$/) do |page_title|
  expect(page.title).to include(page_title)
end

Then(/^I should be on the "(.*?)" page$/) do |page_name|
  expect(current_path).to eq(name_to_path(page_name))
end

Then(/^the navigation bar should be visible$/) do
  expect(page).to have_css('header nav')
end

Then(/^the "(.*?)" item in the navigation bar should be highlighted$/) do |page_name|
  expect(page).to have_css("header nav .#{page_name}.active")
end

Then(/^the Administrator should receive an email$/) do
  pending # express the regexp above with the code you wish you had
end

def name_to_path(page_name)
  page_path(page_name)
end
