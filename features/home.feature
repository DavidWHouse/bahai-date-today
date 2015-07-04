Feature: visitors view the website
  In order to read the content
  As a visitor
  I want see various pages and links

  Scenario: view today's date in the Gregorian calendar
    Given I am on the landing page
    Then I should see today's date in the gregorian calendar

  Scenario: view the navigation bar
    Given I am on the landing page
    Then the navigation bar should be visible
    And the "Home" link should be highlighted

  Scenario Outline: the navigation bar links to various pages
    Given I am on the landing page
    When I click on the <page_name> link
    Then I should be on the "<page_name>" page
    And the "<page_title>" link should be highlighted

    Examples:
      | page_name       | page_title      |
      | bahai-calendar  | Bahá’í Calendar |
      | table-of-dates  | Table of Dates  |
      | about           | About           |

  Scenario: fill in the contact form on the about page
    Given I am on the about page
    When I fill in the contact form
    Then I should see "Thank you"
    And the Administrator should receive an email
