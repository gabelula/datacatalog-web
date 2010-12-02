Feature: Editing data record
  So that I can correct a data error or update information
  As the registered user who created the record
  I want to be able to edit a data record
 
  Background:
    Given a data record titled "Child Birth" exists whose owner's email is "john@doe.com"

  Scenario: An admin edits an existing data record
    Given I am a signed in admin
    When I go to the browse page
    And I follow "Child Birth"
    And I follow the translation of "label_update"
    When I fill in "text_title" with "Birth Rate"
    And I press the translation of "text_submit"
    Then I should see "Birth Rate"
    And I should not see "Child Birth"

  Scenario: An user edits an existing data record that she previously created
    Given I am signed in as "john@doe.com"
    When I go to the browse page
    And I follow "Child Birth"
    And I follow the translation of "label_update"
    When I fill in "text_title" with "Birth Rate"
    And I press the translation of "text_submit"
    Then I should see "Birth Rate"
    And I should not see "Child Birth"

  Scenario: An guest visitor tries to edit an existing data record
    Given I am a site visitor
    When I go to the browse page
    And I follow "Child Birth"
    Then I should not see the translation of "label_update"
