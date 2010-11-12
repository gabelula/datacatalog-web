@signup @users
Feature: Sign up
  In order to register an account for the website
  As a site visitor
  I want to enter in email/password to create an account

  Scenario: Sign up with email/password
    Given I am a site visitor
    When I go to sign up
    And I fill in "name" with "John D."
    And I fill in "email" with "john@test.com"
    And I fill in "password" with "s3krit"
    And I fill in "confirm_password" with "s3krit"
    And I select "Uruguay" from the translation of "country"
    And I fill in "city" with "Montevideo"
    And I select "Journalist" from the translation of "user_type"
    And I press "Sign Up"
    Then my account should be created
    And I should see a translation of "your_account_has_been_created"

  Scenario: Sign up with wrong password confirmation
    Given I am a site visitor
    When I go to sign up
    And I fill in "name" with "Jack D."
    And I fill in "email" with "jack@test.com"
    And I fill in "password" with "s3krit"
    And I fill in "confirm_password" with "sekrit"
    And I press "Sign Up"
    Then my account should not be created
    And I should see a translation of "password_doesnt_match_confirmation"

  Scenario: Attempt to sign up with email address already in system
    Given I am a site visitor who already has signed up with "jane@test.com"
    When I go to sign up
    And I fill in "name" with "Jane D."
    And I fill in "email" with "jane@test.com"
    And I fill in "password" with "s3krit"
    And I fill in "confirm_password" with "s3krit"
    And I press "Sign Up"
    Then I should see a translation of "email_has_already_been_taken"

  Scenario: Confirm my email address after signing up
    Given I have signed up but not yet confirmed
    When I click on the confirmation link
    Then I should see a translation of "thanks_you_are_now_signed_in"
