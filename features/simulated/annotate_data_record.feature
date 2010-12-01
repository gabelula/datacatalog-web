Feature: Adding private notes to data records
  In order to remember important tidbits of information regarding a data record
  As a registered user
  I want to keep private notes about data records

  Background:
    Given I am a signed in user
    And a data record titled "The Data Record" exists

  Scenario: I add a note to a data record
    When I go to the data record's page
    And I write a new note for the data record
    And I follow the translation of "label_private_notes"
    Then I should see my note

  Scenario: I add a note to a data record annotated by someone else
    Given the data record has notes by a different user
    When I go to the data record's page
    And I write a new note for the data record
    And I follow the translation of "label_private_notes"
    Then I should see my note
    And I should not see the other user's notes
