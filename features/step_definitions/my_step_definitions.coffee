myStepDefinitionsWrapper = ->
  @World = require("../support/world.js").World
  @Given /REGEXP/, (callback) ->
    @visit "http://github.com/cucumber/cucumber-js", callback

  @When /REGEXP/, (callback) ->
    callback.pending()

  @Then /REGEXP/, (callback) ->
    unless @isOnPageWithTitle("Cucumber.js demo")
      callback.fail new Error("Expected to be on 'Cucumber.js demo' page")
    else
      callback()

  @Given /^I am on the cucumber\.js github page$/, (callback) ->
    callback.pending()

  @When /^I go to the README file$/, (callback) ->
    callback.pending()

  @Then /^I should see "([^"]*)"$/, (arg1, callback) ->
    callback.pending()

module.exports = myStepDefinitionsWrapper

