@users @admin
Feature: Admin adds an user
  So that I can allow another user utilize all functions of a pop council user and contribute to the world
  As a pop council admin user
  I want to create another pop council admin account in the data catalog

  Scenario Outline: Add a new user from the admin
    Given I am a signed in admin
    When I go to the admin dashboard
    And I follow the translation of "label_user_accounts"
    When I follow the translation of "label_add_new"
    When I select "<role>" from "Role"
    And I fill in "name" with "John D."
    And I fill in "email" with "john@test.com"
    And I fill in "password" with "s3krit"
    And I fill in "confirm_password" with "s3krit"
    And I select "Uruguay" from the translation of "country"
    And I fill in "city" with "Montevideo"
    And I select "Journalist" from the translation of "user_type"
    And I press the translation of "text_create_user"
    Then a new <role> account should be created with "john@test.com"
    And I should see  the translation of "The user was created and notified"

    Examples:
      | role          |
      | Admin         |
      | Ministry User |
      | Normal User   |

  Scenario: Add an user that doesn't validate
    Given I am a signed in admin
    When I go to the admin dashboard
    And I follow the translation of "label_user_accounts"
    When I follow the translation of "label_add_new"
    And I select "Admin" from "Role"
    And I fill in "password" with "something"
    And I fill in "confirm_password" with "something different"
    And I press the translation of "text_create_user"
    Then a new admin account should not be created with "john@test.com"
    And I should see the translation of "password_doesnt_match_confirmation"

  Scenario: Add an user without specifying role
    Given I am a signed in admin
    When I go to the admin dashboard
    And I follow the translation of "label_user_accounts"
    When I follow the translation of "label_add_new"
    And I fill in "name" with "John D."
    And I fill in "email" with "john@test.com"
    And I fill in "password" with "s3krit"
    And I fill in "confirm_password" with "s3krit"
    And I select "Uruguay" from the translation of "country"
    And I fill in "city" with "Montevideo"
    And I select "Journalist" from the translation of "user_type"
    And I press the translation of "text_create_user"
    Then a new Normal User account should be created with "john@test.com"
    And I should see the translation of "the_user_was_created_and_notified"

  Scenario: A newly added admin can log in
    Given I am a site visitor who had an admin account created with "jane@test.com" by an admin
    When I go to sign in
    And I fill in "email" with "jane@test.com"
    And I fill in "password" with "test"
    And I press the translation of "text_sign_in"
    Then I should see the translation of "label_admin"

  Scenario Outline: Creating organizations if they don't exist yet
    Given I am a signed in admin
    And an organization named "DCRA" exists
    When I go to the admin dashboard
    And I follow the translation of "label_user_accounts"
    When I follow the translation of "label_add_new"
    When I select "Normal User" from "Role"
    And I fill in "name" with "John D."
    And I fill in "email" with "john@test.com"
    And I fill in "password" with "s3krit"
    And I fill in "confirm_password" with "s3krit"
    And I select "Uruguay" from the translation of "country"
    And I fill in "city" with "Montevideo"
    And I fill in "affiliation_optional" with "<name>"
    And I select "Journalist" from the translation of "user_type"
    And I press the translation of "text_create_user"
    Then a new Normal User account should be created with "john@test.com"
    And there should be <count> organizations
    And the user should be affiliated with "<name>"

    Examples:
    | name      | count |
    | DCRA      | 1     |
    | Red Cross | 2     |
    |           | 1     |
