@signin @users
Feature: Sign in
  In order to sign in
  As a registered user
  I want to enter my email/password to sign in

  Scenario: Sign in
    Given I have signed up and confirmed
    When I go to sign in
    And I fill in "email" with "some@email.com"
    And I fill in "password" with "test"
    And I press the translation of "label_sign_in"
    Then I should see the translation of "text_you_have_been_signed_in"

  Scenario: Attempt to sign in without confirming
    Given I have signed up but not yet confirmed
    When I go to sign in
    And I fill in "email" with "some@email.com"
    And I fill in "password" with "test"
    And I press the translation of "label_sign_in"
    Then I should see the translation of "text_your_account_is_not_confirmed"
