Feature: Example feature
  As a user of cucumber.js
  I want to have documentation on cucumber
  So that I can concentrate on building awesome applications

  Scenario: Reading documentation
    Given I am on the cucumber.js github page
    When I go to the README file
    Then I should see "Usage"

